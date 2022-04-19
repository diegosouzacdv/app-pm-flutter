import 'package:flutter/material.dart';

class AlertSgpol {
  String titulo;
  String mensagem;
  bool botaoSim;
  String textBotaoCancel;
  String textBotaoOk;
  Function function;

  AlertSgpol({
    @required this.titulo,
    @required this.mensagem,
    this.botaoSim = false,
    this.textBotaoCancel = 'Não',
    this.textBotaoOk = 'Sim',
    @required this.function,
  });
}
