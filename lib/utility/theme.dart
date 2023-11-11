import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MyTheme { light, dark }

// notes status bar
// Brightness.light > bg white & text black
// Brightness.dark > bg black & text white

class ThemeNotifier with ChangeNotifier {
  static List<ThemeData> themes = [
    ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: Color.fromRGBO(17, 143, 82, 1),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              accentColor: const Color.fromRGBO(17, 143, 82, 1),
              brightness: Brightness.light)
          .copyWith(
        background: Colors.white,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    ),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              accentColor: const Color.fromRGBO(17, 143, 82, 1),
              brightness: Brightness.dark)
          .copyWith(background: Colors.black),
      useMaterial3: true,
    ),
  ];

  MyTheme _current = MyTheme.light;
  ThemeData _currentTheme = themes[0];

  void switchTheme() =>
      currentTheme == MyTheme.light ? currentTheme = MyTheme.dark : currentTheme = MyTheme.light;

  set currentTheme(theme) {
    if (theme != null) {
      _current = theme;
      _currentTheme = _current == MyTheme.light ? themes[0] : themes[1];

      notifyListeners();
    }
  }

  MyTheme get currentTheme => _current;
  ThemeData get currentThemeData => _currentTheme;
}
