import 'package:apppmdfflutter/Animations/FadeAnimation.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'login/login_page.dart';

class PresentationScreen extends StatefulWidget {
  PresentationScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PresentationScreenState createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;
  bool hideText = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _widthController.forward();
        }
      });

    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0,
    ).animate(_widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 215.0,
    ).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller.forward();
        }
      });

    _scale2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32.0,
    ).animate(_scale2Controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: LoginPage(),
            ),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: SgpolAppTheme.colorGradientSgpol,
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: 0,
              child: FadeAnimation(
                1,
                Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/one.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(
                1,
                Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/one.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(
                1,
                Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/one.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height * 1,
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                    1,
                    Text(
                      "SGPol",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 5),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "Este sistema é um projeto desenvolvido pela DiTel com a \nfinalidade de padronizar os processos da administração e\ndisponibilizar informações precisas a todos policiais.",
                      style: TextStyle(
                          color: Theme.of(context).accentColor.withOpacity(.8),
                          height: 1.4,
                          letterSpacing: 0.3),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  FadeAnimation(
                    1.6,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              width: _widthAnimation.value,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).accentColor,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    hideText = true;
                                  });
                                  _scaleController.forward();
                                },
                                child: Stack(
                                  children: [
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) =>
                                              Transform.scale(
                                            scale: _scale2Animation.value,
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: SgpolAppTheme
                                                    .colorGradientSgpol,
                                              ),
                                              child: hideIcon == false
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        hideText == false
                                                            ? Text("Entrar",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor))
                                                            : Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor)
                                                      ],
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
