import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';

import 'horizontalCard.dart';

class HorizontalScrollVariant extends StatefulWidget {
  HorizontalScrollVariant();

  @override
  State<StatefulWidget> createState() => HorizontalScrollVariantState();
}

class HorizontalScrollVariantState extends State<HorizontalScrollVariant> {
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
    fetchPublishings();
  }

  @override
  Widget build(BuildContext context) {
    return publishings.length != 0
        ? RefreshIndicator(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Container(
                height: 350.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: publishings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          if (Publish.fromJson(publishings[index]).imageUrl !=
                              null)
                            HorizontalCard(
                                publishings[index], 200.0, 170.0, 250.0, 100.0),
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
