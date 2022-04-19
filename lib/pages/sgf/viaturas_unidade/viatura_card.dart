import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/custom_card_shape_painter.dart';
import 'package:flutter/material.dart';

class ViaturaCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String router;
  final ViaturaDTO viatura;

  const ViaturaCard({
    Key key,
    @required this.animationController,
    @required this.animation,
    @required this.viatura,
    this.router: "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = {
      'router': this.router,
      'arguments': viatura,
    };
    final double _borderRadius = 24;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation.value), 0.0),
              child: Builder(builder: (BuildContext contexto) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(children: [
                    Container(
                      height: 130,
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
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.STANDART_SCREEN,
                                arguments: arguments);
                          },
                          child: CustomPaint(
                            size: Size(80, 150),
                            painter: CustomCardShapePainter(
                              _borderRadius,
                              SgpolAppTheme.primaryColorSgpol,
                              SgpolAppTheme.primaryColorSgpol,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 8),
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: SgpolAppTheme.nearlyBlack,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(
                                            viatura.prefixo != null
                                                ? 'Prefixo: ${viatura.prefixo}'
                                                : 'Prefixo: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: SgpolAppTheme.dark_grey,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            viatura.placa != null
                                                ? 'Placa: ${viatura.placa}'
                                                : 'Placa: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: SgpolAppTheme.dark_grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 45),
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
                        padding:
                            const EdgeInsets.only(top: 15, left: 13, right: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(
                                'https://sgpol.pm.df.gov.br/img/sgf/${viatura?.marcaSigla}.png',
                                height: 30,
                                fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace stackTrace) {
                                        return Icon(Icons.time_to_leave_outlined,
                                      color: SgpolAppTheme.dark_grey);
                                      },
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 180,
                              child: Text(
                                viatura.modelo != null ? viatura.modelo : '',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: SgpolAppTheme.dark_grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                );
              }),
            ),
          );
        });
  }
}
