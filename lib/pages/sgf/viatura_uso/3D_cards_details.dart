import 'package:apppmdfflutter/models/Card3D.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/card_viatura_uso.dart';
import 'package:flutter/material.dart';

class CardsDetails extends StatelessWidget {
  final Card3D card;

  const CardsDetails({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black45,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.1),
          Align(
            child: SizedBox(
              height: 150.0,
              child: Hero(
                tag: card.title,
                child: CardViaturaUso(
                  card: card,
                ),
              ),
            ),
          ),
          Text(
            card.title,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
            const SizedBox(height: 5),
          Text(
            card.author,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
