import 'package:apppmdfflutter/pages/patrimonio/conferencia_form_screen.dart';
import 'package:apppmdfflutter/pages/patrimonio/conferencia_patrimonio.dart';
import 'package:apppmdfflutter/utils/app_bar_sgpol.dart';
import 'package:apppmdfflutter/utils/main_listView_uI_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class ConferenciaScreen extends StatefulWidget {
  final AnimationController animationController;
  const ConferenciaScreen({Key key, this.animationController})
      : super(key: key);

  @override
  _ConferenciaScreenState createState() => _ConferenciaScreenState();
}

class _ConferenciaScreenState extends State<ConferenciaScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool isSelected = false;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scroolController();
    super.initState();
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

    const List<String> carList = [
      "",
    ];

    carList.asMap().forEach((index, element) {
      listViews.add(
        ConferenciaFormScreen(),
      );
      listViews.add(
        ConferenciaPatrimonio(
          animationController: widget.animationController,
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
            AppBarSgpol(widget.animationController, topBarAnimation,
                topBarOpacity, isSelected, 'Conferência', 'Patrimônio'),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
