import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pawstic/globals.dart' as globals;

ThemeData defaultTheme = ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontFamily: 'PoppinsSemiBold',
        fontSize: 17.0,
        color: globals.titleColor),
    headline5: TextStyle(
        fontFamily: 'PoppinsBold', fontSize: 30.0, color: globals.titleColor),
    headline6: TextStyle(
        fontFamily: 'PoppinsSemiBold',
        fontSize: 23.0,
        color: globals.titleColor),
    subtitle1: TextStyle(
        fontFamily: 'PoppinsSemiBold',
        fontSize: 20.0,
        color: globals.titleColor),
    subtitle2: TextStyle(
        fontFamily: 'PoppinsRegular', fontSize: 16.0, color: globals.bodyColor),
    bodyText1: TextStyle(fontSize: 17.0),
    bodyText2: TextStyle(
        fontFamily: 'PoppinsRegular', fontSize: 18.0, color: globals.bodyColor),
  ),
);
