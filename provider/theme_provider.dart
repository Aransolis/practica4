import 'package:flutter/material.dart';
import 'package:practica1/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData = temaDia();
  //double _dimenFont = 1;

 //getdimentFont() => this._dimenFont;
  //setdimentFont(double value) {
    //this._dimenFont = value;
    //notifyListeners();
  //}

  getthemeData() => this._themeData;
  setthemeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}