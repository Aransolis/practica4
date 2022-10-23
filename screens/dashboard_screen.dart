// ignore_for_file: prefer_const_constructors


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';  
import 'package:practica1/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'package:practica1/screens/databaseuser_helper.dart';
import 'package:practica1/models/users_model.dart';
import 'package:path_provider/path_provider.dart';




class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
DatabaseHelper? _database;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 46, 95, 174),
        child: ListView(
          children: [
            FutureBuilder(
              future: _database!.getUser(),
              builder: (context, AsyncSnapshot<List<UsersDAO>> snapshot) {
                if(snapshot.hasData&&snapshot.data?.length!=0){
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://c.wallhere.com/photos/00/76/Leo_Messi_soccer-5698.jpg!d'),
                        fit: BoxFit.cover
                      ),
                    ),
                    currentAccountPicture: 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context, 
                            '/addUser',
                            arguments:{

                              'id_Usuario': snapshot.data![0].idUsuario,
                              'imagen': snapshot.data![0].imagen,
                              'nombre': snapshot.data![0].nombre,
                              'correo': snapshot.data![0].correo,
                              'numero': snapshot.data![0].numero,
                              'urlGit': snapshot.data![0].urlGit,
                            } 
                          ).then((value) {
                            setState(() {});      
                          });
                        },
                        child: Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage: FileImage(File(snapshot.data![0].imagen!)),
                          ),
                          
                        ),
                      ),
                    accountName: Text(
                      snapshot.data![0].nombre!,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    accountEmail: Text(
                      snapshot.data![0].correo!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ); 
                }else{
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://c.wallhere.com/photos/00/76/Leo_Messi_soccer-5698.jpg!d'),
                        
                        fit: BoxFit.cover
                      ),
                    ),
                    
                    currentAccountPicture: 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/addUser').then((value){setState(() {
                            
                          });});
                        },
                        child: Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/default-user-image.jpg',),
                            
                          ),
                          
                        ),
                      ),
                    accountName: Text(
                      'No definido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    accountEmail: Text(
                      'No definido',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              } 
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Practica 1'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Base de datos'),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/task', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Popular Movies'),
              onTap: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/list', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('About Us'),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/abouts', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.setBool('login', true);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
      body: ThemeScreen(),
    );
  }
}
