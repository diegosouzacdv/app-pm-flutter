import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorHttpShowDialog extends StatelessWidget {
  final String mensagem;

  ErrorHttpShowDialog({
    @required this.mensagem,
  });

  @override
  Widget build(BuildContext context) {
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
                'Erro',
                style: TextStyle(
                  fontSize: 24,
                  color: SgpolAppTheme.nearlyWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                mensagem,
                style: TextStyle(
                  fontSize: 16,
                  color: SgpolAppTheme.whiteGradient,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (mensagem == 'FAÇA NOVO LOGIN') {
                        print(mensagem == 'FAÇA NOVO LOGIN');
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      }
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', ModalRoute.withName('/'));
                    },
                    child: Text(
                      'Fechar',
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

dialogAlertErrorHttp({
  @required BuildContext context,
  @required String mensagem,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ErrorHttpShowDialog(
        mensagem: mensagem,
      );
    },
  );
}
