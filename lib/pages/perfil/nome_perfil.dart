import 'package:flutter/material.dart';

class NomePerfil extends StatelessWidget {
  final String nome;
  final AnimationController animationController;
  final Animation animation;

  const NomePerfil(
      {Key key, this.nome = '', this.animationController, this.animation})
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
              child: Text(
                nome,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          );
        });
  }
}
