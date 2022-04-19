import 'dart:convert';

import 'package:apppmdfflutter/exceptions/AuthException.dart';
import 'package:apppmdfflutter/interceptions/sgpol-interceptor.dart';
import 'package:apppmdfflutter/models/isViaturaVistoria.dart';
import 'package:apppmdfflutter/models/policial.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/models/vistoria_viatura.dart';
import 'package:apppmdfflutter/utils/api_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class SGFProvider with ChangeNotifier {
  static const _urlLogin = API_CONFIG.BASE_API;
  http.Client client = InterceptedClient.build(
      interceptors: [SGpolInterceptor()],
      requestTimeout:
      Duration(seconds: 20)
  );

  Map<String, int> _page;

  bool _loadingPesquisaViatura = false;

  bool get loadingPesquisaViatura => _loadingPesquisaViatura;

  List<ViaturaDTO> _listViaturaPesquisa = [];

  Map<String, int> get pageable => _page;

  List<ViaturaDTO> get listViaturaPesquisa => [..._listViaturaPesquisa];

  Future<VistoriaViatura> cautelarViaturaFinalizarVistoria(VistoriaViatura vistoria) async {
    vistoria.dataVistoria = null;
    vistoria.dataLiberacao = null;
    vistoria.vistoriaViaturaItensVistoria = null;

    final response = await client
        .put(
          Uri.parse('$_urlLogin/viatura/vistoria/salvaradjunto/${vistoria.id}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(vistoria),
        );
    Map<dynamic, dynamic> data = await json.decode(response.body);
    notifyListeners();
    return new VistoriaViatura.fromJson(data);
  }

  Future<VistoriaViatura> alterarVistoria(
      VistoriaViatura vistoria, BuildContext context) async {
    vistoria.dataVistoria = null;
    vistoria.vistoriaViaturaItensVistoria = null;
    final response = await client
        .put(Uri.parse('$_urlLogin/viatura/vistoria'),
            headers: {
              "Content-Type": "application/json",
            },
            body: json.encode(vistoria));
    Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data = await json.decode(response.body);
    notifyListeners();
    return new VistoriaViatura.fromJson(data);
  }

  Future<VistoriaViatura> cancelarVistoria(int idVistoria) async {
    print(idVistoria);
    final response = await client.put(Uri.parse('$_urlLogin/viatura/vistoria/invalidar/$idVistoria'), body: {});
    await json.decode(response.body);
    notifyListeners();
    return null;
  }

  Future<VistoriaViatura> inserirVistoria(int idViatura) async {
    print('inserirVistoria');
    final response = await client.post(Uri.parse('$_urlLogin/viatura/vistoria/$idViatura'), body: {});
    Map<dynamic, dynamic> data = await json.decode(response.body);
    notifyListeners();
    return new VistoriaViatura.fromJson(data);
  }

  Future<Map<dynamic, dynamic>> inserirItem(int idItem) async {
    final response = await client.put(Uri.parse('$_urlLogin/viatura/vistoria/item/$idItem'), body: {});
    Map<dynamic, dynamic> data = await json.decode(response.body);
    notifyListeners();
    return data;
  }

  Future<VistoriaViatura> carregarVistoria(int idViatura) async {
    print('carregarVistoria');
    final response = await client
        .get(
          Uri.parse('$_urlLogin/viatura/vistoria/$idViatura'),
        );
    Map<dynamic, dynamic> data = await json.decode(response.body);
    notifyListeners();
    return new VistoriaViatura.fromJson(data);
  }

  Future<IsViaturaVistoria> isVistoriaViatura(int idViatura) async {
    print('isVIstoriaViaturaaaaaaaa');
    final response = await client.get(Uri.parse('$_urlLogin/viatura/vistoria/viaturaTemVistoria/$idViatura'));
    Map<dynamic, dynamic> data = await json.decode(response.body);
    notifyListeners();
    return new IsViaturaVistoria.fromJson(data);
  }

  Future<List<ViaturaDTO>> loadViaturas(Policial policial, int page) async {
    final response = await client.get(Uri.parse('$_urlLogin/viaturas?lotacaoCodigo=${policial.lotacaoCodigo}&size=20&page=$page'));
    Map<dynamic, dynamic> data = await json.decode(response.body);
    if (data != null) {
      _page = {
        'pageAtual': data['pageable']['pageNumber'],
        'totalPage': data['totalPages'],
      };
      final List viaturas = data['content'];

      notifyListeners();
      return viaturas.map((response) => ViaturaDTO.fromJson(response)).toList();
    }
    return Future.value();
  }

  Future<ViaturaDTO> getViatura(int idViatura) async {
    final response = await client
        .get(
          Uri.parse('$_urlLogin/viaturas/$idViatura'),
        );
    Map<dynamic, dynamic> data = await json.decode(response.body);
    notifyListeners();
    return ViaturaDTO.fromJson(data);
  }

  Future<bool> pesquisarViatura(String busca) async {
    _loadingPesquisaViatura = true;
    if (busca == 'false') {
      print('entrando no if para limpar busca');
      _listViaturaPesquisa.clear();
      _loadingPesquisaViatura = false;
      notifyListeners();
      return Future.value(true);
    }
    var placa = '';
    var prefixo = '';
    bool alfa = RegExp('[a-zA-Z]').hasMatch(busca);
    alfa ? placa = busca : prefixo = busca;
    print('$_urlLogin/viaturas?placa=$placa&prefixo=$prefixo&size=5&page=0');
    final response = await client.get(Uri.parse('$_urlLogin/viaturas?placa=$placa&prefixo=$prefixo&size=5&page=0'));
    var data = await json.decode(response.body);
    List<dynamic> listViaturaDTO = data['content'];
    if (listViaturaDTO.length < 1) {
      print('entrando no if da pesquisa zero');
      _loadingPesquisaViatura = false;
      notifyListeners();
      return Future.value(false);
    }
    _listViaturaPesquisa.clear();
    listViaturaDTO.forEach((element) {
      _listViaturaPesquisa.add(ViaturaDTO.fromJson(element));
    });
    _loadingPesquisaViatura = false;
    notifyListeners();
    return Future.value(true);
  }
}
