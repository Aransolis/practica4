import 'package:flutter/material.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    late SharedPreferences _prefs;
 
    return Scaffold(
      body: Center(
        child: Column(children: [
          TextButton.icon(
            onPressed: () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.setString('theme', 'dia');
              tema.setthemeData(temaDia());
              
            },
            icon: Icon(Icons.brightness_1),
            label: Text('Tema de Día'),
          ),
          TextButton.icon(
            onPressed: () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.setString('theme', 'noche');
              tema.setthemeData(temaNoche());
              
            },
            icon: Icon(Icons.dark_mode),
            label: Text('Tema de Noche'),
          ),
          TextButton.icon(
            onPressed: () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.setString('theme', 'calido');
              tema.setthemeData(temaCalido());
              
            },
            icon: Icon(Icons.hot_tub_sharp),
            label: Text('Tema Calido'),
          ),
        ]),
      ),
    );
  }
}
