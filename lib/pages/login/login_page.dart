import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/login/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tab_icon_data.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  double scale;

  @override
  Widget build(BuildContext context) {

            Future<void> _exitApp(bool value) async {
      if (value) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }
    Future<bool> _onBackPressed() {
      //metodo para aparecer caixa de dialogo para fechar o SGPol Mobile
      return showDialog(
            context: context,
            builder: (context) => AlertDialogSgpol(
            titulo: 'Sair',
            mensagem: 'Deseja fechar o SGPol Mobile?',
            respostaAlertDialog: _exitApp,
            botaoSim: true,
            textBotaoOk: 'Sim',
            textBotaoCancel: 'Não',
          ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus(); //esconde o teclado ao apertar fora do input
          }
        },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          body: Stack(children: [
            Container(
              decoration: BoxDecoration(
                gradient: SgpolAppTheme.colorGradientSgpol,
              ),
              padding: EdgeInsets.all(30),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Image.asset("assets/images/logo.png"),
                          radius: 80.0,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).accentColor.withOpacity(0.1),
                        ),
                        child: LoginCard(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                BottomAppBar(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
