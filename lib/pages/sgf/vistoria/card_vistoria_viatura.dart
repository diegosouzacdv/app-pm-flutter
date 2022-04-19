import 'package:apppmdfflutter/models/alert_sgpol.dart';
import 'package:apppmdfflutter/models/isViaturaVistoria.dart';
import 'package:apppmdfflutter/models/policial.dart';
import 'package:apppmdfflutter/models/situacao_viatura.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/models/vistoria_viatura.dart';
import 'package:apppmdfflutter/pages/standart_screen.dart';
import 'package:apppmdfflutter/providers/policial_providers.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/custom_card_shape_painter.dart';
import 'package:apppmdfflutter/widgets/error_http_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardVistoriaViatura extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final String router;
  final ViaturaDTO viatura;

  const CardVistoriaViatura({
    Key key,
    this.animationController,
    this.animation,
    this.router: "",
    this.viatura,
  }) : super(key: key);

  @override
  _CardVistoriaViaturaState createState() => _CardVistoriaViaturaState();
}

class _CardVistoriaViaturaState extends State<CardVistoriaViatura> with TickerProviderStateMixin {
  AnimationController _animationControllerMovement;

  @override
  void initState() {
    _animationControllerMovement = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 880));
    super.initState();
  }

  @override
  void dispose() {
    _animationControllerMovement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = {
      'router': this.widget.router,
      'arguments': this.widget.viatura,
    };

    final Map<String, dynamic> argumentsDetails = {
      'router': AppRoutes.DETALHES_VIATURA,
      'arguments': this.widget.viatura,
    };

    Map<dynamic, dynamic> status = {
      'color': SgpolAppTheme.grey,
      'situacao': '',
      'mensagemAlertDialog': '',
      'tituloAlertDialog': '',
    };
    status = statusViatura(status);

    Future<void> _pageTransition(bool value) async {
      final duration = Duration(milliseconds: 750);
      _animationControllerMovement.forward();
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, _) => FadeTransition(
            opacity: animation,
            child: StandartScreen(arguments: arguments, router: AppRoutes.VISTORIA),
          ),
        ),
      );
      _animationControllerMovement.reverse(from: 1.0);
    }

    Future<void> _pageTransitionDetails() async {
      final duration = Duration(milliseconds: 750);
      _animationControllerMovement.forward();
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, _) => FadeTransition(
            opacity: animation,
            child: StandartScreen(arguments: argumentsDetails, router: argumentsDetails['router']),
          ),
        ),
      );
      _animationControllerMovement.reverse(from: 1.0);
    }

    _avisoAlert(AlertSgpol alert) {
      dialogAlert(
        titulo: alert.titulo,
        mensagem: alert.mensagem,
        botaoSim: alert.botaoSim,
        textBotaoCancel: alert.textBotaoCancel,
        textBotaoOk: alert.textBotaoOk,
        context: context,
        function: alert.function,
      );
    }

    Future<void> onTapRouterVistoria(Map status, BuildContext context, Map<String, dynamic> arguments) async {
      PolicialProvider policialProvider = Provider.of<PolicialProvider>(context, listen: false);
      SGFProvider sgfProvider = Provider.of<SGFProvider>(context, listen: false);
      AlertSgpol alert = new AlertSgpol(
        titulo: status['tituloAlertDialog'],
        mensagem: status['mensagemAlertDialog'],
        function: (_) => '',
        botaoSim: true,
        textBotaoCancel: '',
        textBotaoOk: '',
      );

      await sgfProvider.isVistoriaViatura(widget.viatura.id).then((value) async {
        IsViaturaVistoria isViaturaVistoria = value;
        if (isViaturaVistoria.idVistoria != null) {
          Policial _policial = policialProvider.policial;
          if (value.motoristaMatricula != _policial.matricula) {
            await sgfProvider.carregarVistoria(widget.viatura.id).then((value) {
              VistoriaViatura vistoriaViatura = value;
              if (isViaturaVistoria.idVistoria == vistoriaViatura.id) {
                alert.mensagem = 'Viatura de Prefixo ${widget.viatura?.prefixo} está ${widget.viatura?.status} por ${widget.viatura?.motorista}';
              }
            }).catchError((error) {
              dialogAlertErrorHttp(context: context, mensagem: error);
            });
            alert.titulo = 'Não Permitido';
            alert.botaoSim = false;
            alert.textBotaoCancel = 'Fechar';
            _avisoAlert(alert);
            return Future.value();
          } else if (value.motoristaMatricula == _policial.matricula) {
            alert.mensagem = '${alert.mensagem} ${_policial?.posto} ${_policial?.nomeGuerra} - Lotação: ${_policial?.lotacao}';
            alert = verificaSituacaoViaturaAlertSgpol(status, alert);
          }
        } else {
          alert = verificaSituacaoViaturaAlertSgpol(status, alert);
        }
        alert.function = _pageTransition;
        _avisoAlert(alert);
      }).catchError((error) {
        dialogAlertErrorHttp(context: context, mensagem: error);
      });
    }

    final double _borderRadius = 24;
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: widget.animation,
            child: new Transform(
              transform: new Matrix4.translationValues(0.0, 30 * (1.0 - widget.animation.value), 0.0),
              child: Builder(builder: (BuildContext contexto) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(_borderRadius), topRight: Radius.circular(_borderRadius)),
                        gradient: LinearGradient(
                          colors: [
                            SgpolAppTheme.white,
                            SgpolAppTheme.background,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: SgpolAppTheme.grey,
                            blurRadius: 6,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 13, right: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: widget.viatura.marcaSigla == null
                                  ? Icon(Icons.time_to_leave_outlined, color: SgpolAppTheme.dark_grey)
                                  : Image.network(
                                      'https://sgpol.pm.df.gov.br/img/sgf/${widget.viatura?.marcaSigla}.png',
                                      height: 30,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                        return Icon(Icons.time_to_leave_outlined, color: SgpolAppTheme.dark_grey);
                                      },
                                    ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 180,
                              child: Text(
                                widget.viatura.modelo != null ? '${widget.viatura?.modelo}' : '',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: SgpolAppTheme.primaryColorSgpol,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: SgpolAppTheme.primaryColorSgpol.withOpacity(0.5),
                          onTap: () {
                            onTapRouterVistoria(status, context, arguments);
                          },
                          child: CustomPaint(
                            size: Size(100, 150),
                            painter: CustomCardShapePainter(
                              _borderRadius,
                              SgpolAppTheme.dark_grey,
                              status['color'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 15,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: SgpolAppTheme.primaryColorSgpol,
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(
                                            widget.viatura.prefixo != null ? 'Prefixo: ${widget.viatura.prefixo}' : '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: SgpolAppTheme.dark_grey,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            widget.viatura.placa != null ? 'Placa: ${widget.viatura.placa}' : '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: SgpolAppTheme.dark_grey,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(10),
                                              splashColor: SgpolAppTheme.primaryColorSgpol.withOpacity(0.5),
                                              onTap: () {
                                                _pageTransitionDetails();
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                      'Detalhes da viatura',
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: SgpolAppTheme.nearlyDarkBlue,
                                                        fontWeight: FontWeight.w400,
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
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20, left: 30, right: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    splashColor: SgpolAppTheme.primaryColorSgpol.withOpacity(0.5),
                                    onTap: () {
                                      onTapRouterVistoria(status, context, arguments);
                                    },
                                    child: FittedBox(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.viatura.status != null ? '${widget.viatura.status}' : '',
                                            style: TextStyle(fontSize: 15, color: SgpolAppTheme.white, fontWeight: FontWeight.bold),
                                          ),
                                          if (status['situacao'] != SituacaoViatura.BAIXADA && status['situacao'] != SituacaoViatura.PARA_REVISAO)
                                            Icon(
                                              Icons.arrow_right,
                                              color: SgpolAppTheme.white,
                                              size: 18,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              }),
            ),
          );
        });
  }

  AlertSgpol verificaSituacaoViaturaAlertSgpol(Map<dynamic, dynamic> status, AlertSgpol alert) {
    print('dentro do metodo verificaSituacaoViaturaAlertSgpol');
    print(status['situacao']);
    if (status['situacao'] == SituacaoViatura.CAUTELADA || status['situacao'] == SituacaoViatura.INCORPORADA || status['situacao'] == SituacaoViatura.EM_VISTORIA) {
      alert.botaoSim = true;
      alert.textBotaoOk = 'Continuar';
      alert.textBotaoCancel = 'Fechar';
    } else {
      alert.botaoSim = false;
      alert.textBotaoCancel = 'Fechar';
    }
    return alert;
  }

  Map<dynamic, dynamic> statusViatura(Map<dynamic, dynamic> status) {
    print(this.widget.viatura.status);
    switch (this.widget.viatura.status) {
      case SituacaoViatura.CAUTELADA:
      case SituacaoViatura.EM_USO:
        status['color'] = SgpolAppTheme.colorSuccess;
        status['situacao'] = SituacaoViatura.CAUTELADA;
        status['tituloAlertDialog'] = 'Viatura Cautelada';
        status['mensagemAlertDialog'] = 'A viatura está cautelada por: ';

        break;
      case SituacaoViatura.BAIXADA:
        status['color'] = SgpolAppTheme.colorDanger;
        status['situacao'] = SituacaoViatura.BAIXADA;
        status['tituloAlertDialog'] = 'Viatura Baixada';
        status['mensagemAlertDialog'] = 'A viatura está baixada';
        break;
      case SituacaoViatura.PARA_REVISAO:
        status['color'] = SgpolAppTheme.colorDanger;
        status['situacao'] = SituacaoViatura.PARA_REVISAO;
        status['tituloAlertDialog'] = 'Revisão';
        status['mensagemAlertDialog'] = 'A viatura em revisão';
        break;
      case SituacaoViatura.INCORPORADA:
        status['color'] = SgpolAppTheme.primaryColorSgpol;
        status['situacao'] = SituacaoViatura.INCORPORADA;
        status['tituloAlertDialog'] = 'Viatura em Condição';
        status['mensagemAlertDialog'] = 'A viatura em Condição, deseja iniciar a vistoria ?';
        break;
      case SituacaoViatura.EM_VISTORIA:
        status['color'] = Colors.amber[900];
        status['situacao'] = SituacaoViatura.EM_VISTORIA;
        status['tituloAlertDialog'] = 'Viatura em Vistoria';
        status['mensagemAlertDialog'] = 'A viatura em vistoria por: ';
        break;
    }
    return status;
  }
}