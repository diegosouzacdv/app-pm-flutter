
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/custom_card_shape_painter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MensagemInicioCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const MensagemInicioCard({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _borderRadius = 24;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150,
                enableInfiniteScroll: false,
                autoPlay: false,
              ),
              items: [1, 2].map((e) {
                return Builder(builder: (BuildContext contexto) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(_borderRadius),
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
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: SgpolAppTheme.grey.withOpacity(0.5),
                            onTap: () {},
                            child: CustomPaint(
                              size: Size(80, 150),
                              painter: CustomCardShapePainter(
                                _borderRadius,
                                SgpolAppTheme.white,
                                SgpolAppTheme.dark_grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 8),
                                        child: Container(
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: SgpolAppTheme.background,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Falta um mês para o recadastramento Falta um mês para o recadastramento Falta um mês para o recadastramento ',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: SgpolAppTheme.fontName,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                            color: SgpolAppTheme.dark_grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Detalhes',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: SgpolAppTheme.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.info,
                                        color: SgpolAppTheme.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        bottom: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 13, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                'DPM',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: SgpolAppTheme.nearlyDarkBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.mail_outline,
                                color: SgpolAppTheme.nearlyDarkBlue,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  );
                });
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
