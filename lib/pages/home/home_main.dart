import 'package:apppmdfflutter/pages/home/home_main_screen.dart';
import 'package:apppmdfflutter/pages/perfil/perfil_screen.dart';
import 'package:apppmdfflutter/pages/tab_icon_data.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  Widget tabBody = Container();
  AnimationController animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[4].isSelected = true;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    tabBody = HomeMainScreen(animationController: animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      //metodo para aparecer caixa de dialogo para fechar o SGPol Mobile
      return Future.value();
    }

    Future<void> _alertDialogSgpol(bool value) async {
      await Provider.of<AuthProvider>(context, listen: false).logout();
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            bottom: PreferredSize(
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  height: 4.0,
                ),
                preferredSize: Size.fromHeight(4.0)),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            actionsIconTheme: IconThemeData(
              color: SgpolAppTheme.white,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: 55,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Sair',
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogSgpol(
                      titulo: 'Logout',
                      mensagem: 'Deseja Sair?',
                      respostaAlertDialog: _alertDialogSgpol,
                    );
                  },
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: SgpolAppTheme.primaryColorSgpol,
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: FutureBuilder<bool>(
                    future: getData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: tabBody,
                            ),
                            bottomBar(),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 4) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      HomeMainScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      PerfilScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
