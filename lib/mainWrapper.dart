/// This is the stateful widget that the main application instantiates.
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/publish1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/topBar.dart';
import 'main.dart';

class MainWrapper extends StatefulWidget {
  int _selectedIndex = 0;
  MainWrapper(this._selectedIndex);

  @override
  _MyStatefulWidgetState createState() =>
      _MyStatefulWidgetState(this._selectedIndex);
}

class _MyStatefulWidgetState extends State<MainWrapper> {
  int _selectedIndex = 0;
  _MyStatefulWidgetState(this._selectedIndex);

  static List<Widget> _widgetOptions = <Widget>[
    Main(),
    Publish1(),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    setOnBoardingDone();
  }

  setOnBoardingDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('onBoardingDone', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          SizedBox(height: 50),
          TopBar(),
          Expanded(child: _widgetOptions.elementAt(_selectedIndex))
        ]),
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
            currentIndex: _selectedIndex,
            unselectedItemColor: globals.titleColor,
            selectedItemColor: globals.primaryColor,
            onTap: _onItemTapped,
          ),
        ));
  }
}
