import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_detalhes/card_detalhes_viatura.dart';
import 'package:apppmdfflutter/utils/app_bar_sgpol.dart';
import 'package:apppmdfflutter/utils/main_listView_uI_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class ViaturaDetalhesScreen extends StatefulWidget {
  final ViaturaDTO viatura;
  final AnimationController animationController;
  const ViaturaDetalhesScreen(
      {Key key, @required this.animationController, @required this.viatura})
      : super(key: key);

  @override
  _ViaturaDetalhesScreenState createState() => _ViaturaDetalhesScreenState();
}

class _ViaturaDetalhesScreenState extends State<ViaturaDetalhesScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool isSelected = false;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    print('entrando no detalhes de viatura');
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
    listViews.add(
      CardDetalhesViatura(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / 9) * 4 + 0.5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        viatura: widget.viatura,
      ),
    );
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
            AppBarSgpol(widget.animationController, topBarAnimation,
                topBarOpacity, isSelected, 'Prefixo', widget.viatura != null ? widget.viatura.prefixo : '...'),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
