import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/publish/publish1.dart';

import '../likes/likes.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
  ];

  @override
  void initState() {
    super.initState();
    if (globals.isDrawerOpen) {
      globals.openDrawer();
    } else {
      globals.closeDrawer();
    }
  }

  static List<Widget> _widgetOptions = <Widget>[Main(), Publish1(), Likes()];
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(globals.xOffset, globals.yOffset, 0)
        ..scale(globals.scaleFactor)
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
              globals.closeDrawer();
            });
          }
        },
        child: Column(
          children: [
            Container(
                child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Row(
                children: [
                  globals.isDrawerOpen
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(FeatherIcons.arrowLeft),
                          onPressed: () {
                            setState(() {
                              globals.closeDrawer();
                            });
                          },
                        )
                      : IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(FeatherIcons.menu),
                          onPressed: () {
                            setState(() {
                              globals.openDrawer();
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
