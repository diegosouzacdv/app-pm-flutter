import 'dart:convert';

import 'package:apppmdfflutter/data/store.dart';
import 'package:apppmdfflutter/exceptions/http-exception-sgpol.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';

class SGpolInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({@required RequestData data}) async {
    await Store.getMap('token').then((token) {
      try {
        data.headers["Authorization"] = 'Bearer ${token["token"]}';
      } catch (e) {
        print(e);
      }
    });
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({@required ResponseData data}) async {
    var response =  await json.decode(data.body);
        if (data.statusCode == 400) {
      List<dynamic> dataList = response;
      throw HttpExceptionSGpol(dataList[0]['mensagemUsuario']).toString();
    }
    if (response['error'] != null) {
      throw HttpExceptionSGpol(response['error']).toString();
    }
    return data;
  }
}
