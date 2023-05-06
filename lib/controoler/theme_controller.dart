import 'package:flutter/material.dart';
import 'package:reminder_app/model/theme_model.dart';

class ThemeController extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isdark: false);

  setTheme() {
    themeModel.isdark = !themeModel.isdark;
    notifyListeners();
  }
}
