import 'package:apppmdfflutter/pages/presentation_screen.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void showErrorDialogAuthLogout(String msg, BuildContext context) async {
  await dialogAlert(
    titulo: 'Ocorreu um erro!',
    mensagem: msg,
    botaoSim: false,
    textBotaoCancel: 'Fechar',
    textBotaoOk: '',
    context: context,
    function: (_) => Navigator.of(context).pop(),
  );
  final duration = Duration(milliseconds: 750);
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, _) => FadeTransition(
        opacity: animation,
        child: PresentationScreen(),
      ),
    ),
  );
  await Provider.of<AuthProvider>(context, listen: false).logout();

}



