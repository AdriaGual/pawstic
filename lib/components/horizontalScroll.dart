import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;

import 'horizontalCard.dart';

class HorizontalScroll extends StatefulWidget {
  HorizontalScroll();

  @override
  State<StatefulWidget> createState() => HorizontalScrollState();
}

class HorizontalScrollState extends State<HorizontalScroll> {
  List<dynamic> publishings = [];

  @override
  void initState() {
    super.initState();
    fetchPublishings();
  }

  void fetchPublishings() async {
    var result = await http.get(globals.allPublishingsUrl);
    setState(() {
      publishings = json.decode(result.body);
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchPublishings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return publishings.length != 0
        ? RefreshIndicator(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Container(
                height: 240.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: publishings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          HorizontalCard(
                              publishings[index], 280.0, 235.0, 150.0, 80.0),
                        ],
                      );
                    }),
              ),
            ),
            onRefresh: _getData,
          )
        : Center(child: CircularProgressIndicator());
  }
}
