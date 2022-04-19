import 'dart:math';
import 'dart:ui';

import 'package:apppmdfflutter/models/Card3D.dart';
import 'package:flutter/material.dart';

class CardViaturaUso extends StatelessWidget {
  final Card3D card;

  const CardViaturaUso({
    Key key,
    this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(15.0);
    return PhysicalModel(
      color: Colors.white,
      elevation: 10,
      borderRadius: border,
      child: ClipRRect(
        borderRadius: border,
        child: Image.asset(
          card.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CardItemViatura extends AnimatedWidget {
  final Card3D card;
  final double percent;
  final double height;
  final int depth;
  final ValueChanged<Card3D> onCardSelected;
  final int verticalFactor;

  Animation<double> get animation => listenable;

  const CardItemViatura({
    Key key,
    this.card,
    this.percent,
    this.height,
    this.depth,
    this.onCardSelected,
    this.verticalFactor = 0,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final depthFactor = 50.0;
    final bottomMargin = height / 4.0;
    return Positioned(
      left: 0,
      right: 0,
      top: height + -depth * height / 2.0 * percent - bottomMargin,
      child: Opacity(
        opacity: verticalFactor == 0 ? 1 : 1 - animation.value,
        child: Hero(
          tag: card.title,
          flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) {
            Widget _current;
            if (flightDirection == HeroFlightDirection.push) {
              _current = toHeroContext.widget;
            } else {
              _current = fromHeroContext.widget;
            }
            return AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                final newValue = lerpDouble(0.0, 2 * pi, animation.value);
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(newValue),
                  child: _current,
                );
              },
            );
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(
                0.0,
                verticalFactor * animation.value * MediaQuery.of(context).size.height,
                depth * depthFactor,
              ),
            child: GestureDetector(
              onTap: () {
                onCardSelected(card);
              },
              child: SizedBox(
                height: height,
                child: CardViaturaUso(
                  card: card,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
