import 'dart:convert';

import 'package:apppmdfflutter/exceptions/AuthException.dart';
import 'package:apppmdfflutter/interceptions/sgpol-interceptor.dart';
import 'package:apppmdfflutter/models/policial.dart';
import 'package:apppmdfflutter/utils/api_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class PolicialProvider with ChangeNotifier {
  static const _urlLogin = API_CONFIG.BASE_API;
  Policial _policial = new Policial();

  PolicialProvider([this._policial]);
  http.Client client = InterceptedClient.build(
      interceptors: [SGpolInterceptor()],
      requestTimeout:
      Duration(seconds: 20)
  );
  Policial get policial => _policial;

  Future<Policial> usuarioLogado() async {
    final response = await client.get(Uri.parse('$_urlLogin/usuario/curto')
    );

    Map<String, dynamic> data = json.decode(response.body);
      _policial = Policial(
        codigo: data['codigo'],
        nomeGuerra: data['nomeGuerra'],
        nome: data['nome'],
        matricula: data['matricula'],
        quadro: data['quadro'],
        posto: data['posto'],
        lotacao: data['lotacao'],
        lotacaoCodigo: data['lotacaoCodigo'],
        lotacaoCodigoSubordinacao: data['lotacaoCodigoSubordinacao'],
        cnhRegistro: data['cnh']['cnhRegistro'],
        cnhDataEmissao: data['cnh']['dataEmissao'],
        cnhDataPrimeira: data['cnh']['dataPrimeira'],
        cnhDataValidade: data['cnh']['dataValidade'],
        cnhCategoria: data['cnh']['categoria'],
      );
    notifyListeners();
    return policial;
    
  }
}
