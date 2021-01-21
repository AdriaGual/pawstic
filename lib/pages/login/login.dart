import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawstic/components/textInput.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/main/homeWrapper.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
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
                    child: Text(
                      "¿has olvidado la contraseña?",
                      style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 14.0,
                          color: globals.bodyColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        globals.selectedIndex = 0;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeWrapper()),
                        );
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
                        Text(
                          "Regístrate aquí",
                          style: TextStyle(
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 18.0,
                              color: globals.primaryColor),
                        ),
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
