import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pawstic/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/onBoarding/onBoarding1.dart';

void main() => runApp(Init());

class Init extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Init> {
  bool onBoardingDone = false;

  @override
  void initState() {
    super.initState();
    log('init State');
    loadOnBoardingDone();
    onBoardingDone = false;
  }

  loadOnBoardingDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      onBoardingDone = prefs.getBool('onBoardingDone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      home: OnBoarding1(),
    );
  }

/*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: defaultTheme,
      home: onBoardingDone != null && onBoardingDone
          ? HomeWrapper()
          : OnBoarding1(),
    );
  }*/
}
