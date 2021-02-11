import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pawstic/globals.dart" as globals;
import 'package:shared_preferences/shared_preferences.dart';

import 'onBoarding2.dart';

class OnBoarding1 extends StatefulWidget {
  OnBoarding1({Key key}) : super(key: key);

  @override
  OnBoarding1State createState() => OnBoarding1State();
}

class OnBoarding1State extends State<OnBoarding1> {
  @override
  void initState() {
    super.initState();
  }

  setOnBoardingDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('onBoardingDone', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onBoarding/onBoarding1.png',
              width: 400.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 25),
            Column(children: [
              Text('Encuentra tu mejor amigo',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text(
                    'Nuestra app te mostrará todos los animales en el área.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              SizedBox(height: 30),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnBoarding2()),
                  );
                },
                child: Icon(FeatherIcons.arrowRight),
                backgroundColor: globals.primaryColor,
              ),
              SizedBox(height: 35),
              Image.asset(
                'assets/images/onBoarding/progressBar.png',
              )
            ]),
            SizedBox(height: 30),
          ],
        ),
      )),
    );
  }
}
