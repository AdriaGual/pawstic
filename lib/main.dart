import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawstic/components/horizontalScrollVariant.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/theme.dart';

import 'components/filterBreed.dart';
import 'components/horizontalScroll.dart';
import 'components/searchBar.dart';

class Main extends StatefulWidget {
  Main();

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<Main> {
  void fetchPublishings() async {
    var result = await http.get(globals.allPublishingsUrl);
    setState(() {
      globals.publishings = json.decode(result.body);
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchPublishings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawstic',
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBar(),
                SizedBox(height: 20),
                FilterBreed(),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Container(
                      child: Text('Urgente',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                ),
                HorizontalScroll(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Container(
                      child: Text('Cercanos',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                ),
                HorizontalScrollVariant(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
