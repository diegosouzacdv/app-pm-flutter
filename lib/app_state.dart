import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int selectedMenuId = 0;

  void updateCategoryId(int selectedMenuId) {
    this.selectedMenuId = selectedMenuId;
    notifyListeners();
  }
}
