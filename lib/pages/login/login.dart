import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:pawstic/components/textInput.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/login/forgotPassword.dart';
import 'package:pawstic/pages/login/register.dart';
import 'package:pawstic/pages/main/homeWrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final name = TextEditingController();
  final password = TextEditingController();
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    name.dispose();
    password.dispose();
    super.dispose();
  }

  bool isEmailAddressValid(String email) {
    RegExp exp = new RegExp(
      r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$",
      caseSensitive: false,
      multiLine: false,
    );
    return exp.hasMatch(email.trim());
    // we trim to remove trailing white spaces
  }

  Future<Null> loginUser() async {
    var response = await http.post(
      globals.loginUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': name.text,
        'password': password.text,
      }),
    );
    final Map parsed = json.decode(response.body);
    if (parsed['ok']) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', parsed['usuario']['_id']);
      globals.selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeWrapper()),
      );
    } else {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text(
                  "Campos no válidos",
                  style: TextStyle(
                      fontFamily: 'PoppinsSemiBold',
                      fontSize: 19.0,
                      color: globals.titleColor),
                ),
                content: new Text("Email y/o contraseña no válidos.",
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: globals.bodyColor)),
                actions: <Widget>[
                  TextButton(
                    child: Text('Aceptar',
                        style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                            fontSize: 15.0,
                            color: globals.primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(alignment: Alignment.center, children: [
          Positioned(
              bottom: 50,
              child: Image.asset(
                'assets/images/login/login.png',
                width: 200.0,
                fit: BoxFit.cover,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                children: [
                  Row(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          FeatherIcons.arrowLeft,
                          size: 30,
                        ),
                        onPressed: () {
                          globals.selectedIndex = 0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeWrapper()),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: 30.0,
                    )
                  ]),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text('Iniciar sesión',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextInput(name, 'Nombre', false),
                  SizedBox(height: 20),
                  TextInput(password, 'Contraseña', true),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      },
                      child: Text(
                        "¿has olvidado la contraseña?",
                        style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                            fontSize: 14.0,
                            color: globals.bodyColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        loginUser();
                      },
                      label: Text(
                        "Entrar",
                        style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                            fontSize: 16.0,
                            color: globals.whiteColor),
                      ),
                      backgroundColor: globals.primaryColor,
                    ),
                  ),
                  Expanded(
                      child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      children: [
                        Text(
                          "¿Aún no tienes cuenta?",
                          style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16.0,
                              color: globals.bodyColor),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                          child: Text(
                            "Regístrate aquí",
                            style: TextStyle(
                                fontFamily: 'PoppinsSemiBold',
                                fontSize: 18.0,
                                color: globals.primaryColor),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ))
        ])),
      ),
    );
  }
}
