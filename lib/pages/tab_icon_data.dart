import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.text = '',
    this.index = 0,
    this.icon,
    this.isSelected = false,
    this.animationController,
  });

  String text;
  IconData icon;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      text: 'SGF',
      icon: Icons.directions_car,
      index: 0,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      text: 'Mensagens',
      icon: Icons.local_post_office,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      text: 'Patrimônio',
      icon: Icons.preview_outlined,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      text: 'Perfil',
      icon: Icons.perm_identity,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      text: 'Início',
      icon: Icons.home,
      index: 4,
      isSelected: false,
      animationController: null,
    ),
  ];
}
