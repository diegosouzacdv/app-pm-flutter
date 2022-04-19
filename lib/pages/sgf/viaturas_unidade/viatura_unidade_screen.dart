import 'package:apppmdfflutter/models/policial.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/pages/sgf/viaturas_unidade/viatura_card.dart';
import 'package:apppmdfflutter/providers/policial_providers.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_bar_sgpol.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/main_listView_uI_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/error_http_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViaturaUnidadeScreen extends StatefulWidget {
  final AnimationController animationController;
  const ViaturaUnidadeScreen({Key key, this.animationController})
      : super(key: key);

  @override
  _ViaturaUnidadeScreenState createState() => _ViaturaUnidadeScreenState();
}

class _ViaturaUnidadeScreenState extends State<ViaturaUnidadeScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool isSelected = false;
  int _page = 0;
  Map<String, int> _pageable;
  Policial _policial;
  SGFProvider _sgf;
  List<ViaturaDTO> _viaturas = [];

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    _page = 0;
    getViaturas();

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scroolController();
    super.initState();
  }

    @override
  void dispose() {
    widget.animationController.dispose();
    super.dispose();
  }

  void getViaturas() async {
    _policial = Provider.of<PolicialProvider>(context, listen: false).policial;
    _sgf = Provider.of<SGFProvider>(context, listen: false);
    await _sgf.loadViaturas(_policial, _page).then((value) {
      pageable();
      _viaturas = value.toList();

      addAllListData();
    }).catchError((error) {
      dialogAlertErrorHttp(context: context, mensagem: error.toString());
    });
  }

  pageable() {
    setState(() {
      _pageable = _sgf.pageable;
    });
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
    scrollController.addListener(() async {
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

      if (scrollController.offset ==
              (scrollController.position.maxScrollExtent) &&
          lastPage()) {
        _page = _page + 1;

        await _sgf.loadViaturas(_policial, _page).then((value) {
          setState(() {
            _viaturas..addAll(value);
            pageable();
            listViews.clear();
          });

          addAllListData();
        }).catchError((error) {
          dialogAlertErrorHttp(context: context, mensagem: error);
        });
      }
    });
  }

  bool lastPage() {
    List<int> pagee = [];
    _pageable.forEach((key, value) {
      pagee.add(value);
    });

    return pagee[0] != pagee[1] ? true : false;
  }

  void addAllListData() {
    final int count = _viaturas.length;

    _viaturas.asMap().forEach((index, value) {
      listViews.add(
        ViaturaCard(
          key: ValueKey(value.id),
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * index + 0.5, 1.0,
                      curve: Curves.fastOutSlowIn))),
          router: AppRoutes.DETALHES_VIATURA,
          animationController: widget.animationController,
          viatura: value,
        ),
      );
    });
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
                'Viaturas',
                _policial.lotacao != null ? '${_policial.lotacao}' : ''),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10, bottom: 8, left: 10),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: SearchBar(pesquisaViatura: _pesquisaViatura),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
