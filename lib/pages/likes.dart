import 'dart:core';

import 'package:flutter/material.dart';
import 'package:pawstic/api/publish_api.dart';
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
          FutureBuilder(
              future: fetchPublishings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("API Error");
                  } else {
                    print(context);
                    print(snapshot.data[0].name);
                    return GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text("He'd have you all unravel at the"),
                          color: Colors.teal[100],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Heed not the rabble'),
                          color: Colors.teal[200],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Sound of screams but the'),
                          color: Colors.teal[300],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.teal[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.teal[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.teal[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.teal[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.teal[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.teal[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Revolution is coming...'),
                          color: Colors.teal[500],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Revolution, they...'),
                          color: Colors.teal[600],
                        ),
                      ],
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    ));
  }
}
