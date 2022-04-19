import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/custom_card_shape_painter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardViaturasPatio extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const CardViaturasPatio({Key key, this.animationController, this.animation})
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
                            splashColor: Colors.red.withOpacity(0.5),
                            onTap: () {},
                            child: CustomPaint(
                              size: Size(80, 150),
                              painter: CustomCardShapePainter(
                                _borderRadius,
                                SgpolAppTheme.white,
                                Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://www.spider-vo.com/wp-content/uploads/2019/04/logo-renault.jpg',
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kwid Intens 10MT',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: SgpolAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color: SgpolAppTheme.darkText),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Prefixo: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: SgpolAppTheme.dark_grey,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Placa: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: SgpolAppTheme.dark_grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Saída',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: SgpolAppTheme.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.exit_to_app,
                                      color: SgpolAppTheme.white,
                                      size: 18,
                                    ),
                                  ],
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
                              top: 10, left: 10, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                'Entrada: ',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: SgpolAppTheme.nearlyDarkBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Container(
                                    child: Text(
                                      '19/08/2020 16h00',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: SgpolAppTheme.nearlyDarkBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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
