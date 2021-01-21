import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:pawstic/components/textInput.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/main/homeWrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  List<String> emails = [];

  List<dynamic> users = [];
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<Null> fetchUsers() async {
    var result = await http.get(globals.allUsersUrl);
    setState(() {
      users = json.decode(result.body);
      var i = 0;
      for (i = 0; i < users.length; i++) {
        emails.add(users[i]['email']);
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    name.dispose();
    email.dispose();
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

  Future<Null> createAccount() async {
    if (isEmailAddressValid(email.text)) {
      var response = await http.post(
        globals.allUsersUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name.text,
          'email': email.text,
          'password': password.text,
        }),
      );
      final Map parsed = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', parsed['_id']);
      globals.selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeWrapper()),
      );
    }
  }

  bool emailAlreadyUsed() {
    bool used = false;
    for (String usedEmail in emails) {
      if (usedEmail == email.text) {
        used = true;
      }
    }

    return used;
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
                            MaterialPageRoute(builder: (context) => Login()),
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
                      child: Text('¡Bienvenido!',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextInput(name, 'Nombre', false),
                  SizedBox(height: 20),
                  TextInput(email, 'Email', false),
                  SizedBox(height: 20),
                  TextInput(password, 'Contraseña', true),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (!isEmailAddressValid(email.text) ||
                            name.text.isEmpty ||
                            password.text.isEmpty ||
                            emailAlreadyUsed()) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                'Campos no válidos',
                                style: TextStyle(
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 19.0,
                                    color: globals.titleColor),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    if (name.text.isEmpty)
                                      Text('El campo Nombre es obligatorio',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 15.0,
                                              color: globals.bodyColor)),
                                    if (password.text.isEmpty)
                                      Text('El campo Contraseña es obligatorio',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 15.0,
                                              color: globals.bodyColor)),
                                    if (!isEmailAddressValid(email.text))
                                      Text(
                                          'El campo Email debe contener mínimo un @ seguido de 4 carácteres.',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 15.0,
                                              color: globals.bodyColor)),
                                    if (emailAlreadyUsed())
                                      Text(
                                          'Este Email ya pertenece a una cuenta.',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 15.0,
                                              color: globals.bodyColor)),
                                  ],
                                ),
                              ),
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
                            ),
                          );
                        } else {
                          createAccount();
                          /*globals.selectedIndex = 0;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeWrapper()),
                        );*/
                        }
                      },
                      label: Text(
                        "Crear cuenta",
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
                          "¿Tienes una cuenta?",
                          style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16.0,
                              color: globals.bodyColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            "Inicia sesión",
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
