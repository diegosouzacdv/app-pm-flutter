import 'dart:convert';

import 'package:apppmdfflutter/interceptions/sgpol-interceptor.dart';
import 'package:apppmdfflutter/models/isViaturaVistoria.dart';
import 'package:apppmdfflutter/models/policial.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/models/vistoria_viatura.dart';
import 'package:apppmdfflutter/utils/api_config.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class PesquisaProvider with ChangeNotifier {
  static const _urlLogin = API_CONFIG.BASE_API;
  http.Client client = InterceptedClient.build(
      interceptors: [SGpolInterceptor()],
      requestTimeout:
      Duration(seconds: 20)
  );

  String _pesquisa;

  String get pesquisa => _pesquisa;

 Future<void> setPesquisa(String busca) {
   _pesquisa = busca;
   notifyListeners();
   return Future.value();
 }
}
