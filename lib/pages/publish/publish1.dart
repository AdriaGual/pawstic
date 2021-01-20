import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pawstic/components/radioInputPublish.dart';
import 'package:pawstic/components/textInput.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/specie.dart';
import 'package:pawstic/pages/publish/publish2.dart';
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;

import '../../components/colorSelector.dart';
import '../../components/dropDownInputSpecies.dart';

class Publish1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Publish1State();
}

class Publish1State extends State<Publish1> {
  final name = TextEditingController();
  final breed = TextEditingController();
  List<DropdownMenuItem<Specie>> dropdownSpecies;

  List<Specie> speciesItems = [
    Specie(1, "Perro"),
    Specie(2, "Gato"),
    Specie(3, "Conejo"),
    Specie(4, "Pájaro"),
    Specie(5, "Otro")
  ];

  void initState() {
    super.initState();
    dropdownSpecies = buildDropDownMenuItems(speciesItems);

    createPublishService.specieSelected = dropdownSpecies[0].value;
  }

  List<DropdownMenuItem<Specie>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Specie>> items = [];
    for (Specie listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    name.dispose();
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
              child: Text('Publicar anuncio',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
          SizedBox(height: 20),
          TextInput(name, 'Nombre del animal'),
          SizedBox(height: 15),
          TextInput(breed, 'Raza'),
          SizedBox(height: 15),
          DropDownInputSpecies(dropdownSpecies),
          SizedBox(height: 15),
          RadioInputPublish(),
          SizedBox(height: 5),
          Align(
              alignment: Alignment.topLeft,
              child:
                  Text('Color', style: Theme.of(context).textTheme.headline4)),
          SizedBox(height: 15),
          ColorSelector(),
          SizedBox(height: 25),
          FloatingActionButton(
            onPressed: () {
              createPublishService.name = name.text;
              createPublishService.breed = breed.text;
              if (breed.text.isEmpty || name.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      'Tienes campos sin rellenar',
                      style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 19.0,
                          color: globals.titleColor),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          if (name.text.isEmpty)
                            Text('El campo Nombre es obligatorio',
                                style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 15.0,
                                    color: globals.bodyColor)),
                          if (breed.text.isEmpty)
                            Text('El campo Raza es obligatorio',
                                style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 15.0,
                                    color: globals.bodyColor)),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Aceptar',
                            style: TextStyle(
                                fontFamily: 'PoppinsSemiBold',
                                fontSize: 15.0,
                                color: globals.primaryColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Publish2()),
                );
              }
            },
            child: Icon(FeatherIcons.arrowRight),
            backgroundColor: globals.primaryColor,
          ),
          SizedBox(height: 30),
          Image.asset(
            'assets/images/Publish/progressBarPublish1.png',
          ),
        ],
      ),
    ));
  }
}
