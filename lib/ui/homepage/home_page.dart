import 'package:apppmdfflutter/data/store.dart';
import 'package:apppmdfflutter/models/menu.dart';
import 'package:apppmdfflutter/models/pages.dart';
import 'package:apppmdfflutter/models/versao.dart';
import 'package:apppmdfflutter/pages/presentation_screen.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/providers/policial_providers.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/error_http_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import '../../utils/sgpol_app_theme.dart';
import 'event_widget.dart';
import 'home_page_background.dart';
import 'menu_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController _animationControllerMovement;
  Animation _animationMenu;
  Versao versaoBD;

  @override
  void initState() {
    _getPolicial();
    _permissoesAcesso();
    _animationControllerMovement = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _animationMenu = Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(_animationControllerMovement);
    super.initState();
  }

  @override
  void dispose() {
    _animationControllerMovement.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies do home_page');
  }




  _permissoesAcesso() async {
    await Store.getMap('userData').then((userData) async {
      var permissoes = parseStringToList(userData);
      await permissoes.asMap().forEach((i, val) {
        var permissao = val.trim();
        print(permissao);
        switch (permissao) {
          case 'ROLE_APP_ADMIN':
            setState(() {
              menus[5].permissions = true;
              pages[5].permissions = true;
            });
            break;
          case 'ROLE_SGF_MOTORISTA':
          case 'ROLE_SGF_ADJUNTO':
            setState(() {
              pages[3].permissions = true;
            });
            break;
        }
      });
    });
  }

  parseStringToList(Map<String, dynamic> userData) {
    RegExp colchete1 = RegExp(r'\[');
    RegExp colchete2 = RegExp(r'\]');
    var permissoes = userData['authorities'].replaceAll(colchete1, '').replaceAll(colchete2, '');
    permissoes = permissoes.split(',');
    return permissoes;
  }

  int transformarNum(String versao) {
  var space = versao.split('.').join('');
  return int.tryParse(space);
}

  _getPolicial() async {
    await Provider.of<PolicialProvider>(context, listen: false).usuarioLogado().then((value) {}).catchError((error) async {
      await Provider.of<AuthProvider>(context, listen: false).logout();
      dialogAlertErrorHttp(context: context, mensagem: error);
    });
  }

  Animation animation() {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval((1 / 9) * 4, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _animationControllerMovement.forward();
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

    Future<void> _pageTransitionAlertDialogSgpol(bool value) async {
      final duration = Duration(milliseconds: 750);
      _animationControllerMovement.forward();
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
      _animationControllerMovement.reverse(from: 1.0);
      await Provider.of<AuthProvider>(context, listen: false).logout();
    }


    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        child: Scaffold(
          body: ChangeNotifierProvider<AppState>(
            create: (_) => AppState(),
            child: Stack(
              children: <Widget>[
                HomePageBackground(
                  screenHeight: MediaQuery.of(context).size.height,
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "PMDF",
                                style: fadedTextStyle,
                              ),
                              Spacer(),
                              Icon(
                                Icons.person_outline,
                                color: Color(0x99FFFFFF),
                                size: 30,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.logout,
                                  color: Color(0x99FFFFFF),
                                ),
                                tooltip: 'Sair',
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialogSgpol(
                                      botaoSim: true,
                                      textBotaoCancel: 'Não',
                                      textBotaoOk: 'Sair',
                                      titulo: 'Logout',
                                      mensagem: 'Deseja Sair?',
                                      respostaAlertDialog: _pageTransitionAlertDialogSgpol,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            "SGpol",
                            style: whiteHeadingTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Consumer<AppState>(
                            builder: (context, appState, _) =>
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      for (final menu in menus)
                                        if (menu.permissions != null && menu.permissions)
                                          MenuWidget(
                                            menu: menu,
                                          )
                                    ],
                                  ),
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Consumer<AppState>(
                            builder: (context, appState, _) =>
                                SingleChildScrollView(
                                  child: FadeTransition(
                                    opacity: _animationMenu,
                                    child: Column(
                                      children: <Widget>[
                                        for (final page in pages.where((e) => e.menusIds.contains(appState.selectedMenuId)))
                                          if (page.permissions != null && page.permissions)
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20),
                                              child: EventWidget(
                                                page: page,
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),

                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
