import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/models/vistoria_viatura.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_vistoria/card_form_vistoria.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_vistoria/itens_alteracoes.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_bar_sgpol.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/main_listView_uI_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/error_http_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViaturaVistoriaScreen extends StatefulWidget {
  final AnimationController animationController;
  final ViaturaDTO viatura;
  const ViaturaVistoriaScreen(
      {Key key, this.animationController, @required this.viatura})
      : super(key: key);

  @override
  _ViaturaVistoriaScreenState createState() => _ViaturaVistoriaScreenState();
}

class _ViaturaVistoriaScreenState extends State<ViaturaVistoriaScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool isSelected = false;
  bool _isLoading = true;

  VistoriaViatura vistoriaViatura =
      new VistoriaViatura(vistoriaViaturaItensVistoria: []);
  ViaturaDTO viatura = new ViaturaDTO();
  List<Widget> listViews = <Widget>[];
  ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  SGFProvider sgfProvider;

  @override
  void initState() {
    setState(() {
      viatura = widget.viatura;
    });
    initSgfProvider();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scroolController();
    super.initState();
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    sgfProvider = Provider.of(context, listen: false);
    super.didChangeDependencies();
  }

  Future<void> initSgfProvider() async {
    sgfProvider = Provider.of(context, listen: false);
    print('initSgfProvider');
    await sgfProvider.isVistoriaViatura(viatura.id).then((value) async {
      if (value.idVistoria == null) {
        await sgfProvider.inserirVistoria(viatura.id).then((value) async {
          if (value.id != null) {
            await getVistoriaViatura(sgfProvider);
            setState(() {
              _isLoading = false;
            });
          } else {
            final Map<String, dynamic> arguments = {
              'router': AppRoutes.VIATURA_VISTORIA,
              'arguments': null,
            };
            Navigator.of(context)
                .pushNamed(AppRoutes.STANDART_SCREEN, arguments: arguments);
          }
        }).catchError((error) {
          dialogAlertErrorHttp(context: context, mensagem: error.toString());
        });
      } else {
        await getVistoriaViatura(sgfProvider);
      }
    }).catchError((error) {
      dialogAlertErrorHttp(context: context, mensagem: error.toString());
    });
    return Future.value();
  }

  Future<void> getVistoriaViatura(SGFProvider sgfProvider) async {
    await sgfProvider.carregarVistoria(viatura.id).then((value) async {
      setState(() {
        vistoriaViatura = value;
        _isLoading = false;
      });
      await getViatura(sgfProvider);
    }).catchError((error) {
      dialogAlertErrorHttp(context: context, mensagem: error.toString());
    });
    return Future.value();
  }

  Future<void> getViatura(SGFProvider sgfProvider) async {
    await sgfProvider.getViatura(viatura.id).then((value) {
      setState(() {
        viatura = value;
        _isLoading = false;
      });
    }).catchError((error) {
      dialogAlertErrorHttp(context: context, mensagem: error.toString());
    });
    return Future.value();
  }

  void scroolController() {
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
      if (scrollController.offset >= 13) {
        setState(() {
          isSelected = true;
        });
      } else if (scrollController.offset <= 13 &&
          scrollController.offset >= 0) {
        setState(() {
          isSelected = false;
        });
      }
    });
  }

  void addAllListData() {
    //const int count = 9;

    listViews.add(Container());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SgpolAppTheme.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32.0),
          topLeft: Radius.circular(32.0),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            MainListViewUI(
                widget.animationController, listViews, scrollController, false),
            AppBarSgpol(
                widget.animationController,
                topBarAnimation,
                topBarOpacity,
                isSelected,
                'Prefixo',
                viatura.prefixo != "" ? viatura.prefixo : ""),
            if (_isLoading)
              Container(
                child: Center(
                    child: Image.asset('assets/images/ripple.gif'),
                  ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: NestedScrollView(
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return <Widget>[
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return Column(
                                          children: <Widget>[],
                                        );
                                      },
                                      childCount: 1,
                                    ),
                                  ),
                                  SliverPersistentHeader(
                                    pinned: true,
                                    floating: true,
                                    delegate: ContestTabHeader(
                                      ItensAlteracoes(
                                          context: context,
                                          itens: vistoriaViatura
                                              .vistoriaViaturaItensVistoria),
                                    ),
                                  ),
                                ];
                              },
                              body: CardFormVistoria(
                                animation: Tween<double>(begin: 0.0, end: 1.0)
                                    .animate(CurvedAnimation(
                                        parent: widget.animationController,
                                        curve: Interval((1 / 5) + 0.5, 1.0,
                                            curve: Curves.fastOutSlowIn))),
                                animationController: widget.animationController,
                                vistoriaViatura: vistoriaViatura,
                                viatura: viatura,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
