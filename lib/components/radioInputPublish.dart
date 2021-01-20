import 'package:flutter/material.dart';
import "package:pawstic/globals.dart" as globals;
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;
import 'package:pawstic/service/createPublishService.dart';

class RadioInputPublish extends StatefulWidget {
  RadioInputPublish();

  @override
  State<StatefulWidget> createState() => RadioInputPublishState();
}

class RadioInputPublishState extends State<RadioInputPublish> {
  RadioInputPublishState();

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: ListTile(
        title: Radio(
          activeColor: globals.primaryColor,
          value: Gender.macho,
          groupValue: createPublishService.genderSelected,
          onChanged: (Gender value) {
            setState(() {
              createPublishService.genderSelected = value;
            });
          },
        ),
        leading: Text(
          'Macho',
          style: TextStyle(
              fontFamily: 'PoppinsSemiBold',
              fontSize: 17.0,
              color: globals.titleColor),
        ),
      )),
      Expanded(
        child: ListTile(
          title: Radio(
            activeColor: globals.primaryColor,
            value: Gender.hembra,
            groupValue: createPublishService.genderSelected,
            onChanged: (Gender value) {
              setState(() {
                createPublishService.genderSelected = value;
              });
            },
          ),
          leading: Text(
            'Hembra',
            style: TextStyle(
                fontFamily: 'PoppinsSemiBold',
                fontSize: 17.0,
                color: globals.titleColor),
          ),
        ),
      )
    ]);
  }
}
