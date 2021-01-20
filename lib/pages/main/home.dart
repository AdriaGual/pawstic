import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/publish/publish1.dart';

import 'main.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
  ];

  void openDrawer() {
    xOffset = 230;
    yOffset = 150;
    scaleFactor = 0.6;
    globals.isDrawerOpen = true;
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    globals.isDrawerOpen = false;
  }

  List<Map> categories = [
    {'name': 'Cats', 'iconPath': 'images/cat.png'},
    {'name': 'Dogs', 'iconPath': 'images/dog.png'},
    {'name': 'Bunnies', 'iconPath': 'images/rabbit.png'},
    {'name': 'Parrots', 'iconPath': 'images/parrot.png'},
    {'name': 'Horses', 'iconPath': 'images/horse.png'}
  ];

  static List<Widget> _widgetOptions = <Widget>[
    Main(),
    Publish1(),
    Text(
      'Index 2: School',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(globals.isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(globals.isDrawerOpen ? 30 : 0.0)),
      child: SingleChildScrollView(
          child: GestureDetector(
        onTap: () {
          if (globals.isDrawerOpen) {
            setState(() {
              closeDrawer();
            });
          }
        },
        child: Column(
          children: [
            Container(
                child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  globals.isDrawerOpen
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(FeatherIcons.arrowLeft),
                          onPressed: () {
                            setState(() {
                              closeDrawer();
                            });
                          },
                        )
                      : IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(FeatherIcons.menu),
                          onPressed: () {
                            setState(() {
                              openDrawer();
                            });
                          }),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 30.0,
                  ),
                ],
              ),
            )),
            _widgetOptions.elementAt(globals.selectedIndex)
          ],
        ),
      )),
    );
  }
}
