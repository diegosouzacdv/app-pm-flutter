import 'package:apppmdfflutter/pages/login/login_page.dart';
import 'package:apppmdfflutter/pages/patrimonio/conferencia_screen.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_detalhes/viatura_detalhes_screen.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/viatura_uso_screen.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_vistoria/viatura_vistoria_screen.dart';
import 'package:apppmdfflutter/pages/sgf/viaturas_unidade/viatura_unidade_screen.dart';
import 'package:apppmdfflutter/pages/sgf/vistoria/vistoria_screen.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StandartScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;
  final String router;

  const StandartScreen({Key key, this.arguments, this.router}) : super(key: key);

  @override
  _StandartScreenState createState() => _StandartScreenState();
}

class _StandartScreenState extends State<StandartScreen>
    with TickerProviderStateMixin {
  var argumentos;
  String rotas;

  AnimationController animationController;

  Widget tabBody = Container();

  @override
  void initState() {
    print('initState do standart screen');
    print(widget.arguments);
    print(widget.router);
    widget.arguments != null ? argumentos = widget.arguments['arguments'] : null;
    widget.router != null ? rotas = widget.router : null;
    tabBody = Container(
      child: Center(
        child: Center(
          child: Image.asset('assets/images/ripple.gif'),
        ),
      ),
    );
    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  pageRoute({String router, dynamic arguments}) {
    if (router == AppRoutes.VIATURA_UNIDADE) {
      tabBody = ViaturaUnidadeScreen(animationController: animationController);
    } else if (router == AppRoutes.DETALHES_VIATURA) {
      tabBody = ViaturaDetalhesScreen(animationController: animationController, viatura: arguments);
    } else if (router == AppRoutes.VIATURA_VISTORIA) {
      tabBody = VistoriaScreen(animationController: animationController);
    } else if (router == AppRoutes.VISTORIA) {
      tabBody = ViaturaVistoriaScreen(animationController: animationController, viatura: arguments);
    } else if (router == AppRoutes.CONFERENCIA) {
      tabBody = ConferenciaScreen(animationController: animationController);
    } else if (router == AppRoutes.VIATURA_USO) {
      tabBody = ViaturaUsoScreen(
        animationController: animationController,
        viatura: arguments,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _alertDialogSgpol(bool value) async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      await Provider.of<AuthProvider>(context, listen: false).logout();
    }

    final router = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print('print da var router');
    print(router);
    router != null ? pageRoute(router: router['router'], arguments: router['arguments']) : pageRoute(router: rotas, arguments: argumentos);

    final mediaQuery = MediaQuery.of(context);

    //pageRoute();
    return GestureDetector(
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(
              top: mediaQuery.padding.top,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'Voltar',
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  SizedBox(
                    height: 60,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
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
                          respostaAlertDialog: _alertDialogSgpol,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  SgpolAppTheme.primaryColorSgpol,
                  SgpolAppTheme.primaryColorContrastSgpol,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          preferredSize: Size(mediaQuery.size.width, 60.0),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SgpolAppTheme.primaryColorSgpol,
                    SgpolAppTheme.primaryColorContrastSgpol,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
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
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
