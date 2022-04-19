import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu {
  final int menuId;
  final String name;
  final IconData icon;
  bool permissions = true;

  Menu({this.menuId, this.name, this.icon, this.permissions});
}

final allMenu = Menu(
  menuId: 0,
  name: "Início",
  icon: Icons.home,
  permissions: true,
);

final sgfMenu = Menu(
  menuId: 1,
  name: "SGF",
  icon: Icons.commute_outlined,
  permissions: true,
);

final patrimonioMenu = Menu(
  menuId: 2,
  name: "Patrimônio",
  icon: Icons.pending_sharp,
  permissions: true,
);

final saudeMenu = Menu(
  menuId: 3,
  name: "Saúde",
  icon: Icons.check_box,
  permissions: true,
);

final mensagensMenu = Menu(
  menuId: 4,
  name: "Mensagens",
  icon: Icons.mail,
  permissions: true,
);
final admMenu = Menu(
  menuId: 5,
  name: "Administrador",
  icon: Icons.admin_panel_settings,
  permissions: false,
);

final menus = [
  allMenu,
  sgfMenu,
  patrimonioMenu,
  saudeMenu,
  mensagensMenu,
  admMenu,
];
