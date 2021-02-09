import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pawstic/globals.dart" as globals;

import 'onBoarding3.dart';

class OnBoarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Expanded(child:
            Image.asset(
              'assets/images/onBoarding/onBoarding2.png',
              width: 400.0,
              fit: BoxFit.cover,
            )),
            SizedBox(height: 25),
            Text('Conoce su historia',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text(
                  'Habla con sus dueños y descubre el pasado de cada amigo.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(height: 30),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoarding3()),
                );
              },
              child: Icon(FeatherIcons.arrowRight),
              backgroundColor: globals.primaryColor,
            ),
            SizedBox(height: 40),
            Image.asset(
              'assets/images/onBoarding/progressBar2.png',
            ),
            SizedBox(height: 30),
          ],
        ),
      )),
    );
  }
}
