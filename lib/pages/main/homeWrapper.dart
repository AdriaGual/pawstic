import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import "package:pawstic/globals.dart" as globals;

import 'drawerWrapper.dart';
import 'home.dart';

class HomeWrapper extends StatefulWidget {
  HomeWrapper();

  @override
  HomeWrapperState createState() => HomeWrapperState();
}

class HomeWrapperState extends State<HomeWrapper> {
  void _onItemTapped(int index) {
    setState(() {
      globals.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
          children: [DrawerWrapper(), Home()],
        )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.home,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.plus,
                  size: 30,
                ),
                label: 'Publish',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.heart,
                  size: 30,
                ),
                label: 'Favorites',
              ),
            ],
            currentIndex: globals.selectedIndex,
            unselectedItemColor: globals.titleColor,
            selectedItemColor: globals.primaryColor,
            onTap: _onItemTapped,
          ),
        ));
  }
}
