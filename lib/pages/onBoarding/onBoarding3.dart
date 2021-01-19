import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pawstic/globals.dart" as globals;

import '../../mainWrapper.dart';

class OnBoarding3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Image.asset(
              'assets/images/onBoarding/onBoarding3.png',
              width: 400.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 25),
            Text('Vive nuevas aventuras',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text('Disfruta de tus mejores momentos junto a ellos.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainWrapper(0)),
                  );
                },
                label: Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      "Empezar",
                      style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 16.0,
                          color: globals.whiteColor),
                    ),
                    SizedBox(width: 15),
                    Icon(FeatherIcons.arrowRight),
                  ],
                ),
                backgroundColor: globals.primaryColor,
              ),
            ),
            SizedBox(height: 40),
            Image.asset(
              'assets/images/onBoarding/progressBar3.png',
            ),
          ],
        ),
      ),
    );
  }
}
