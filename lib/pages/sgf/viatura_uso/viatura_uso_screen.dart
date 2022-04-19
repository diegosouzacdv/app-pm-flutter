import 'package:apppmdfflutter/models/Card3D.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/3D_cards_details.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/card_viatura_uso.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/viatura_uso_list.dart';
import 'package:apppmdfflutter/utils/app_bar_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class ViaturaUsoScreen extends StatefulWidget {
  final ViaturaDTO viatura;
  final AnimationController animationController;

  const ViaturaUsoScreen({Key key, @required this.animationController, @required this.viatura}) : super(key: key);

  @override
  _ViaturaUsoScreenState createState() => _ViaturaUsoScreenState();
}

class _ViaturaUsoScreenState extends State<ViaturaUsoScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool isSelected = false;
  double topContainer = 0;
  double paddingLR = 20;
  ScrollController scrollListController = ScrollController();
  double topBarOpacity = 0.0;

  void onListen() {
    double value = scrollListController.offset / 119;
    setState(() {
      topContainer = value;
    });

    if (scrollListController.offset >= 24) {
      if (topBarOpacity != 1.0) {
        setState(() {
          topBarOpacity = 1.0;
        });
      }
    } else if (scrollListController.offset <= 24 && scrollListController.offset >= 0) {
      if (topBarOpacity != scrollListController.offset / 24) {
        setState(() {
          topBarOpacity = scrollListController.offset / 24;
        });
      }
    } else if (scrollListController.offset <= 0) {
      if (topBarOpacity != 0.0) {
        setState(() {
          topBarOpacity = 0.0;
        });
      }
    }
    if (scrollListController.offset >= 13) {
      setState(() {
        isSelected = true;
        paddingLR = 0;
      });
    } else if (scrollListController.offset <= 13 && scrollListController.offset >= 0) {
      setState(() {
        isSelected = false;
        paddingLR = 20;
      });
    }
  }

  @override
  void initState() {
    scrollListController.addListener(onListen);
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollListController.removeListener(onListen);
    widget.animationController.dispose();
    super.dispose();
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
          body: Stack(children: [
            // ViaturaUsoList(
            //   animationController: widget.animationController,
            //   scrollListController: scrollListController,
            //   topContainer: topContainer,
            // ),
            AppBarSgpol(
              widget.animationController,
              topBarAnimation,
              topBarOpacity,
              isSelected,
              'Viaturas',
              'cauteladas',
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: paddingLR == 0
                      ? AppBar().preferredSize.height + MediaQuery.of(context).padding.top + paddingLR - 5
                      : AppBar().preferredSize.height + MediaQuery.of(context).padding.top + paddingLR,
                  left: paddingLR,
                  right: paddingLR,
                ),
              ),
            ),
          Column(
            children: [
              Expanded(
                flex: 3,
                child: CardBody(),
              ),
            ],
          ),
          ])
          ),
    );
  }
}

