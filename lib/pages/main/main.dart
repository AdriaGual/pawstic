import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:pawstic/components/horizontalScrollVariant.dart';
import "package:pawstic/globals.dart" as globals;

import '../../components/filterBreed.dart';
import '../../components/horizontalScroll.dart';
import '../../components/searchBar.dart';

class Main extends StatefulWidget {
  Main();

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    log("start");
    fetchPublishings();

  }

  Future<Null> fetchPublishings() async {
    var result;
    await Future.delayed(Duration(milliseconds: 50));
    Future getFuture() {
      return Future(() async {
        result = await http.get(globals.allPublishingsUrl);
        return result;
      });
    }

    await showDialog(
        context: context,
        child: FutureProgressDialog(
          getFuture(),
        ));

    setState(() {
      globals.publishings = [];
      globals.urgentPublishings = [];
      globals.otherPublishings = [];
      globals.publishings = json.decode(result.body);
      globals.publishings.sort((a, b) => DateTime.parse(a['dateCreated'])
          .compareTo(DateTime.parse(b['dateCreated'])));
      if (globals.publishings.length > 3) {
        for (var a in globals.publishings) {
          globals.urgentPublishings.add(a);
          globals.otherPublishings.add(a);
        }
        globals.urgentPublishings
            .removeRange(3, globals.urgentPublishings.length);

        globals.otherPublishings.removeRange(0, 3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SearchBar(),
          FilterBreed(),
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
          HorizontalScroll(globals.urgentPublishings),
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
    ));
  }
}
