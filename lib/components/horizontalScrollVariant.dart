import 'package:flutter/material.dart';
import "package:pawstic/globals.dart" as globals;

import 'horizontalCard.dart';

class HorizontalScrollVariant extends StatefulWidget {
  HorizontalScrollVariant();

  @override
  State<StatefulWidget> createState() => HorizontalScrollVariantState();
}

class HorizontalScrollVariantState extends State<HorizontalScrollVariant> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: Container(
        height: 350.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: globals.otherPublishings.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  if (globals.otherPublishings[index].imageUrl != null)
                    HorizontalCard(globals.otherPublishings[index], 200.0,
                        170.0, 250.0, 100.0),
                ],
              );
            }),
      ),
    );
  }
}
