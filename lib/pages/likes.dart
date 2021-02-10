import 'dart:core';

import 'package:flutter/material.dart';
import 'package:pawstic/components/radioInputPublish.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Likes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LikesState();
}

class LikesState extends State<Likes> {
  bool userLogged = false;

  void initState() {
    super.initState();
    isUserLogged();
  }

  Future<Null> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? "";
    if (userId != "") {
      setState(() {
        userLogged = true;
      });
    } else {
      userLogged = false;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Me gusta',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(height: 15),
          RadioInputPublish(),
          SizedBox(height: 5),
          Align(
              alignment: Alignment.topLeft,
              child:
                  Text('Color', style: Theme.of(context).textTheme.headline4)),
          SizedBox(height: 15),
        ],
      ),
    ));
  }
}
