import 'package:flutter/material.dart';
import 'package:pawstic/globals.dart' as globals;

class FilterBreed extends StatefulWidget {
  FilterBreed();

  @override
  State<StatefulWidget> createState() => FilterBreedState();
}

class FilterBreedState extends State<FilterBreed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  globals.publishings = [];
                  globals.urgentPublishings = [];
                  globals.otherPublishings = [];
                });
              },
              child: Text('Perros',
                  style: TextStyle(
                      fontFamily: 'PoppinsMedium',
                      fontSize: 16.0,
                      color: globals.bodyColor))),
          Spacer(),
          Text('Gatos',
              style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontSize: 16.0,
                  color: globals.bodyColor)),
          Spacer(),
          Text('Conejos',
              style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontSize: 16.0,
                  color: globals.bodyColor)),
          Spacer(),
          Text('Pájaros',
              style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontSize: 16.0,
                  color: globals.bodyColor)),
          Spacer(),
          Text('Otros',
              style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontSize: 16.0,
                  color: globals.bodyColor)),
        ],
      ),
    );
  }
}
