import 'package:apppmdfflutter/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import '../../utils/sgpol_app_theme.dart';

class MenuWidget extends StatelessWidget {
  final Menu menu;

  const MenuWidget({Key key, this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSelected = appState.selectedMenuId == menu.menuId;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          appState.updateCategoryId(menu.menuId);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.white : Color(0x99FFFFFF), width: 3),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              menu.icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              menu.name,
              style: isSelected ? selectedMenuTextStyle : menuTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
