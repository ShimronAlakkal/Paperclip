import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData dark = ThemeData(
  accentColor: Colors.amberAccent,
  primaryColor: Colors.amber,
  brightness: Brightness.dark,
);

ThemeData light = ThemeData(
  accentColor: Colors.amberAccent,
  primaryColor: Colors.amber,
  brightness: Brightness.light,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  // ignore: unused_field
  SharedPreferences _preferences;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  // ignore: unused_element
  changeTheme() {
    _darkTheme = !_darkTheme;

    debugPrint(
        'the dark theme value is $_darkTheme and the key is $key ********  changing the theme  but the original darktheme is $darkTheme ');
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _preferences.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _preferences.setBool(key, _darkTheme);
  }
}
