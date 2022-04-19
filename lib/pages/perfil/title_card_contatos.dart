import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class TitleCardContatos extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final IconData icon;
  final AnimationController animationController;
  final Animation animation;

  const TitleCardContatos(
      {Key key,
      this.titleTxt: "",
      this.subTxt: "",
      this.icon,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            icon,
                            color: SgpolAppTheme.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          titleTxt,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: SgpolAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            color: SgpolAppTheme.grey,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                subTxt,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: SgpolAppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  color: SgpolAppTheme.darkText,
                                ),
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
          ),
        );
      },
    );
  }
}
