import 'package:apppmdfflutter/pages/presentation_screen.dart';
import 'package:apppmdfflutter/pages/update-app/update-app.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/ui/homepage/home_page.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/botao_outline_sgpol.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class UpdateOrHomeScreen extends StatefulWidget {
  @override
  _UpdateOrHomeScreenState createState() => _UpdateOrHomeScreenState();
}

class _UpdateOrHomeScreenState extends State<UpdateOrHomeScreen> {
  String version = "";

  @override
  void initState() {
    _getVersao();
    super.initState();
  }

  _getVersao() async => await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        version = packageInfo.version;
      });

  int transformarNum(String versao) {
    var space = versao.split('.').join('');
    return int.tryParse(space);
  }

  @override
  Widget build(BuildContext context) {
    print('entrando no UpdateOrHomeScreen');
    AuthProvider authProvider = Provider.of(context);
    Future<void> _alertDialogSgpol(bool value) async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PresentationScreen(),
        ),
      );
      await Provider.of<AuthProvider>(context, listen: false).logout();
    }

    Future<Widget> _submit(bool value) async {
      print('print do submit');
      print(value);
      return AlertDialogSgpol(
        botaoSim: true,
        textBotaoCancel: 'Não',
        textBotaoOk: 'Sair',
        titulo: 'Logout',
        mensagem: 'Deseja Sair?',
        respostaAlertDialog: _alertDialogSgpol,
      );
    }
    return FutureBuilder(
      future: authProvider.versaoApp(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('dentro do if do UpdateOrHomeScreen');
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
                    'Aguarde, verificando se há atualização disponível.',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Image.asset('assets/images/ripple.gif'),
                ],
              ),
            ),
          );
        } else if (snapshot.error != null) {
          print(snapshot);
          print('dentro do else if do UpdateOrHomeScreen');
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
                    'Ocorreu um erro inesperado',
                    style: Theme.of(context).textTheme.subtitle2,
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
          final versaoApp = transformarNum(version);
          final versaoBanco = transformarNum(snapshot.data.versao.toString());
          return versaoApp < versaoBanco ? UpdateApp(versao: snapshot.data) : HomePage();
        }
      },
    );
  }
}
