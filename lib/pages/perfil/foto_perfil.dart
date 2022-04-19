import 'package:flutter/material.dart';

class FotoPerfil extends StatelessWidget {
  final String url;
  final AnimationController animationController;
  final Animation animation;

  const FotoPerfil(
      {Key key, this.url = '', this.animationController, this.animation})
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
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(url),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
