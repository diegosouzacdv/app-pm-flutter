import 'package:apppmdfflutter/pages/presentation_screen.dart';
import 'package:apppmdfflutter/pages/update-app/update_home_screen.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/botao_outline_sgpol.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _alertDialogSgpol(bool value) async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PresentationScreen(),
        ),
      );
      await Provider.of<AuthProvider>(context, listen: false).logout();
    }

    Future<void> _submit(bool value) async {
      return AlertDialogSgpol(
        botaoSim: true,
        textBotaoCancel: 'Não',
        textBotaoOk: 'Sair',
        titulo: 'Logout',
        mensagem: 'Deseja Sair?',
        respostaAlertDialog: _alertDialogSgpol,
      );
    }



    AuthProvider authProvider = Provider.of(context);
    return FutureBuilder(
      future: authProvider.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('dentro do if do AuthOrUpdateScreen');
          return Container(
            decoration: new BoxDecoration(
              gradient: SgpolAppTheme.colorGradientSgpol,
            ),
            child: Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Sgpol Mobile',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Aguarde, verificando usuário logado.',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Image.asset('assets/images/ripple.gif'),
                ],
              ),
            ),
          );
        } else if (snapshot.error != null) {
          print('dentro do if else do AuthOrUpdateScreen');
          return Container(
            decoration: new BoxDecoration(
              gradient: SgpolAppTheme.colorGradientSgpol,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Sgpol Mobile',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Ocorreu um erro inesperado',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  BotaoOutlineSgpol(
                    textButton: 'Sair',
                    iconButton: Icons.logout,
                    colorButtonSgpol: SgpolAppTheme.whiteGradient,
                    onpressButton: _submit,
                  ),
                ],
              ),
            ),
          );
        } else {
          print('dentro do else do AuthOrUpdateScreen');
          return authProvider.isAuth ? UpdateOrHomeScreen() : PresentationScreen();
        }
      },
    );
  }
}
