import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/cupertino.dart';

class Card3D {
  final String title;
  final String author;
  final String image;
  final Color color;

  Card3D({this.author, this.title, this.image, this.color});
}

const _path = 'assets/3D_cards_animation';
final cardList = [
  Card3D(author: 'Troye Sivan', title: 'Blue Neighbourhood', image: '$_path/1.png', color: SgpolAppTheme.grey),
  Card3D(author: 'Bundii Staxxx', title: 'The Escape', image: '$_path/2.png', color: SgpolAppTheme.primaryColorSgpol),
  Card3D(author: 'Queen', title: 'Bohemian Rhapsody', image: '$_path/3.png', color: SgpolAppTheme.colorDanger),
  Card3D(author: 'Ed Sheran', title: 'Perfect', image: '$_path/4.png', color: SgpolAppTheme.colorSuccess),
  Card3D(author: 'Ryan Jones', title: 'Pain', image: '$_path/5.png', color: SgpolAppTheme.darkText),
  Card3D(author: 'Troye Sivan', title: 'Blue Neighbourhood', image: '$_path/1.png', color: SgpolAppTheme.grey),
  Card3D(author: 'Bundii Staxxx', title: 'The Escape', image: '$_path/2.png', color: SgpolAppTheme.primaryColorSgpol),
  Card3D(author: 'Queen', title: 'Bohemian Rhapsody', image: '$_path/3.png', color: SgpolAppTheme.colorDanger),
  Card3D(author: 'Ed Sheran', title: 'Perfect', image: '$_path/4.png', color: SgpolAppTheme.colorSuccess),
  Card3D(author: 'Ryan Jones', title: 'Pain', image: '$_path/5.png', color: SgpolAppTheme.darkText),
  Card3D(author: 'Troye Sivan', title: 'Blue Neighbourhood', image: '$_path/1.png', color: SgpolAppTheme.grey),
  Card3D(author: 'Bundii Staxxx', title: 'The Escape', image: '$_path/2.png', color: SgpolAppTheme.primaryColorSgpol),
  Card3D(author: 'Queen', title: 'Bohemian Rhapsody', image: '$_path/3.png', color: SgpolAppTheme.colorDanger),
  Card3D(author: 'Ed Sheran', title: 'Perfect', image: '$_path/4.png', color: SgpolAppTheme.colorSuccess),
  Card3D(author: 'Ryan Jones', title: 'Pain', image: '$_path/5.png', color: SgpolAppTheme.darkText),
  Card3D(author: 'Troye Sivan', title: 'Blue Neighbourhood', image: '$_path/1.png', color: SgpolAppTheme.grey),
  Card3D(author: 'Bundii Staxxx', title: 'The Escape', image: '$_path/2.png', color: SgpolAppTheme.primaryColorSgpol),
  Card3D(author: 'Queen', title: 'Bohemian Rhapsody', image: '$_path/3.png', color: SgpolAppTheme.colorDanger),
  Card3D(author: 'Ed Sheran', title: 'Perfect', image: '$_path/4.png', color: SgpolAppTheme.colorSuccess),
  Card3D(author: 'Ryan Jones', title: 'Pain', image: '$_path/5.png', color: SgpolAppTheme.darkText),
];
