import 'package:flutter/material.dart';
import "package:pawstic/globals.dart" as globals;

import 'horizontalCard.dart';

class HorizontalScroll extends StatefulWidget {
  HorizontalScroll();

  @override
  State<StatefulWidget> createState() => HorizontalScrollState();
}

class HorizontalScrollState extends State<HorizontalScroll> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: Container(
        height: 230.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: globals.urgentPublishings.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  if (globals.urgentPublishings[index].imageUrl != null)
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      alignment: Alignment.topLeft,
                      child: HorizontalCard(globals.urgentPublishings[index],
                          280.0, 235.0, 150.0, 80.0),
                    )
                ],
              );
            }),
      ),
    );
  }
}
