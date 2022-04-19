import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarSgpol extends StatelessWidget {
  final AnimationController animationController;
  Animation<double> topBarAnimation;
  double topBarOpacity;
  bool isSelected;
  String titulo;
  String subTitulo;

  AppBarSgpol(this.animationController, this.topBarAnimation,
      this.topBarOpacity, this.isSelected, this.titulo, this.subTitulo);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (0.9 - topBarAnimation.value), 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF000041).withOpacity(topBarOpacity),
                        Color(0xFF030917).withOpacity(topBarOpacity)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: SgpolAppTheme.primaryColorSgpol
                              .withOpacity(0.6 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  titulo,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: SgpolAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: isSelected
                                        ? SgpolAppTheme.white
                                        : SgpolAppTheme.darkText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    subTitulo.toUpperCase(),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: SgpolAppTheme.fontName,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: 1.3,
                                      color: isSelected
                                          ? SgpolAppTheme.white
                                          : SgpolAppTheme.darkText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
