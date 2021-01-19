import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';

import 'horizontalCard.dart';

class HorizontalScroll extends StatefulWidget {
  HorizontalScroll();

  @override
  State<StatefulWidget> createState() => HorizontalScrollState();
}

class HorizontalScrollState extends State<HorizontalScroll> {
  List<dynamic> publishings = [];
  List<dynamic> showPublishings = [];
  @override
  void initState() {
    super.initState();
    fetchPublishings();
  }

  Future<Null> fetchPublishings() async {
    var result = await http.get(globals.allPublishingsUrl);
    setState(() {
      publishings = json.decode(result.body);
      if (publishings.length > 3) {
        publishings.sort((a, b) => DateTime.parse(a['dateCreated'])
            .compareTo(DateTime.parse(b['dateCreated'])));
        publishings.removeRange(3, publishings.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: Container(
        height: 240.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: publishings.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  if (Publish.fromJson(publishings[index]).imageUrl != null)
                    HorizontalCard(
                        publishings[index], 280.0, 235.0, 150.0, 80.0),
                ],
              );
            }),
      ),
    );
  }
}
