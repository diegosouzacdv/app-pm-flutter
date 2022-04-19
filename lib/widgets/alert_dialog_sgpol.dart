import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class AlertDialogSgpol extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final Function(bool) respostaAlertDialog;
  final bool botaoSim;
  final String textBotaoCancel;
  final String textBotaoOk;

  AlertDialogSgpol({
    @required this.titulo,
    @required this.mensagem,
    @required this.respostaAlertDialog,
    this.botaoSim = false,
    this.textBotaoCancel = 'Não',
    this.textBotaoOk = 'Sim',
  });

  respostaDialog(bool value) {
    respostaAlertDialog(value);
  }

  @override
  Widget build(BuildContext context) {
    print('entrando no AlertDialogSgpol');
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }


  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            gradient: SgpolAppTheme.colorGradientSgpol,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: SgpolAppTheme.nearlyWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: SgpolAppTheme.whiteGradient,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (textBotaoCancel.isNotEmpty)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      textBotaoCancel,
                      style: TextStyle(
                        fontSize: 18,
                        color: SgpolAppTheme.nearlyWhite,
                      ),
                    ),
                  ),
                  if (botaoSim)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        respostaAlertDialog(true);
                      },
                      child: Text(
                        textBotaoOk,
                        style: TextStyle(
                          fontSize: 18,
                          color: SgpolAppTheme.nearlyWhite,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: AssetImage('assets/images/alertdialog.gif'),
            )),
      ],
    );
  }
}

dialogAlert({
  @required BuildContext context,
  @required String titulo,
  @required String mensagem,
  bool botaoSim = false,
  String textBotaoCancel = 'Não',
  String textBotaoOk = 'Sim',
  Function function ,
}) {
  print('entrando no dialog');
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogSgpol(
        titulo: titulo,
        mensagem: mensagem,
        respostaAlertDialog: function,
        botaoSim: botaoSim,
        textBotaoOk: textBotaoOk,
        textBotaoCancel: textBotaoCancel,
      );
    },
  );
}
