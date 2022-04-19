import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apppmdfflutter/data/store.dart';
import 'package:apppmdfflutter/exceptions/AuthException.dart';
import 'package:apppmdfflutter/interceptions/sgpol-interceptor.dart';
import 'package:apppmdfflutter/models/versao.dart';
import 'package:apppmdfflutter/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class AuthProvider with ChangeNotifier {
  static const _urlLogin = API_CONFIG.BASE_API;
  var _storage = FlutterSecureStorage();
  String _token;
  Versao _versao;
  DateTime _expiryDate;
  Timer _logoutTimer;

  http.Client client = InterceptedClient.build(
      interceptors: [SGpolInterceptor()],
      requestTimeout:
      Duration(seconds: 20)
  );

  bool get isAuth {
    return token != null;
  }

  Versao get versao {
    return _versao != null ? _versao : null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<Versao> versaoApp() async {
    final response = await client.get(Uri.parse('$_urlLogin/versao'));
    Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data = await json.decode(response.body);
    _versao = Versao.fromJson(data);
    return new Versao.fromJson(data);
  }

  Future<void> login(String usuario, String senha, bool salveUser) async {
    if (salveUser) {
      setUserLocalStorage(usuario, senha);
    } else {
      clearUserLocalStorage();
    }

    var base64encoded = base64.encode(latin1.encode(senha));

    final body = 'login=appsgpol&username=$usuario&password=$base64encoded&grant_type=password';

    print(Uri.parse('$_urlLogin/oauth/token'));
    final response = await http.post(
      Uri.parse('$_urlLogin/oauth/token'),
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic YXBwc2dwb2w6QHBwc2dwQGw=',
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      },
    ).timeout(
      Duration(seconds: 20),
      onTimeout: () => throw AuthException("Sem conexão com o Servidor"),
    );
    final responseBody = await json.decode(response.body);
    print(responseBody.toString());
    if (responseBody["error"] != null) {
      throw AuthException(responseBody["error_description"]);
    } else {
      _token = responseBody["access_token"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: responseBody["expires_in"],
        ),
      );

      await Store.saveMap('token', {
        "token": _token,
        "expiryDate": _expiryDate.toIso8601String(),
      });

      _autoLogout();
      notifyListeners();
      tokenJwt(responseBody);
    }
    return Future.value();
  }

  Future<void> tokenJwt(dynamic token) async {
    String tokenString = token.toString();
    if (tokenString == null) return null;
    final parts = tokenString.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);

    Store.saveMap('userData', {
      'id': '${payloadMap['user_name']}',
      'authorities': '${payloadMap['authorities']}',
    });

    notifyListeners();
    return Future.value();
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    }
    final token = await Store.getMap('token');
    if (token == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(token["expiryDate"]);
    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }
    _token = token["token"];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
    return Future.value();
  }

  Future<void> setUserLocalStorage(String usuario, String senha) async {
    var credencials = {'usuario': usuario, 'senha': senha};
    await _storage.write(
        key: 'user',
        value: base64.encode(utf8.encode(json.encode(credencials))));
  }

  Future<Map<String, dynamic>> getUserLocalStorage() async {
    var value = await _storage.read(key: 'user');
    return value != null
        ? json.decode(utf8.decode(base64.decode(value)))
        : {'usuario': '', 'senha': ''};
  }

  Future<Null> clearUserLocalStorage() async {
    await _storage.delete(key: 'user');
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }

    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    Store.remove('token');
    Store.remove('userData');
    notifyListeners();
    return Future.value();
  }
}
