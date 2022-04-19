import 'package:apppmdfflutter/main.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAvisoCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String aviso =
      'Realize seu recadastramento anualmente no mês de aniversário ou no mês anterior, a partir de 2019. \n'
      ' Em caso de problema com usuário Inativo/Pensionista contactar a DIPC no telefone 3190-6134, em caso de problemas com usuário ativo contactar a DPM no telefone 3190-6055.';

  const HomeAvisoCard({Key key, this.animationController, this.animation})
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor("#D7E0F9"),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: SgpolAppTheme.primaryColorSgpol
                                      .withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, bottom: 12, right: 16, top: 13),
                                child: Text(
                                  aviso,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: SgpolAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: SgpolAppTheme.nearlyDarkBlue
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 0,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                            "assets/images/aviso.svg",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
