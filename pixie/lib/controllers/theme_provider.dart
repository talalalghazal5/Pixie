import 'package:flutter/material.dart';
import 'package:pixie/UI/themes/dark_theme.dart';
import 'package:pixie/UI/themes/light_theme.dart';
import 'package:pixie/main.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;

  ThemeData get theme => _theme;

  bool get isDarkMode => preferences.getBool('darkMode') ?? _theme == darkTheme;

  set theme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  void toggleTheme () {
    if (isDarkMode) {
      theme = lightTheme;
      preferences.setBool('darkMode', false);
    } else {
      theme = darkTheme;
      preferences.setBool('darkMode', true);
    }
  }
}