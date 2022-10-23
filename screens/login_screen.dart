// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practica1/firebase/email_authentication.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:practica1/screens/theme_screen.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailAuthentication _emailAuth = EmailAuthentication();


  bool? isChecked = false;

  late SharedPreferences _prefs;
  late bool newuser;
  late String t;

  void initState() {
    super.initState();
    checar_existe_login();
  }

  checar_existe_login() async {
    _prefs = await SharedPreferences.getInstance();
    newuser = (_prefs.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
  }

  definirTema() async {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    _prefs = await SharedPreferences.getInstance();
    t = (_prefs.getString('theme') ?? 'dia');

    if (t == 'dia') {
      tema.setthemeData(temaDia());
    } else if (t == 'noche') {
      tema.setthemeData(temaNoche());
    } else if (t == 'calido') {
      tema.setthemeData(temaCalido());
    }
  }

  @override
  Widget build(BuildContext context) {
    definirTema();
    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
        hintText: 'Introduce el usuario ',
        label: Text('Correo Electronico'),
      ),
      //onChanged: (value){},
    );
    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Introduce el password ', label: Text('Contraseña')),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                'assets/messiLogo.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20,
                bottom: MediaQuery.of(context).size.width / 20,
              ),
              color: Color.fromARGB(255, 255, 253, 253),
              child: ListView(
                shrinkWrap: true,
                children: [
                  txtUser,
                  SizedBox(
                    height: 15,
                  ),
                  txtPwd
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 30,
              child: GestureDetector(
                onTap: () async {
                  //var ban = await _auth.signInWithEmailAndPassword(email: txtConUser.text, password: txtConPwd.text);
                  //if(ban == true){
                  //if(_auth.currentUser!.emailVerified)
                    Navigator.pushNamed(context, '/onboarding');
                  //else
                   // print('Usuario no validado');
                  //}else{
                   // print('Credenciales Invalidads');
                  //}
                },
                child: Image.asset('assets/balon.png',
                    height: MediaQuery.of(context).size.width / 4),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 15,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20),
                //color: Colors.black,
                width: MediaQuery.of(context).size.width / 1.0,
                child: Column(
                  //shrinkWrap: true,
                  children: [
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.facebook,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.github,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      //width: double.infinity,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () {},
                    ),
                    CheckboxListTile(
                      value: isChecked,
                      title: const Text(
                        'Guardar Sesión',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 19,
                            fontWeight: FontWeight.w700),
                      ),
                      onChanged: (value) async {
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        setState(() {
                          isChecked = value!;
                          _prefs.setBool('login', false);
                        });
                      },
                      secondary: const Icon(Icons.safety_check,
                          color: Colors.red, size: 40),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                right: MediaQuery.of(context).size.width / 1,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'signup'),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
