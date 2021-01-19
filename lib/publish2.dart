import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pawstic/components/imageFileContainer.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/mainWrapper.dart';
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;
import 'package:pawstic/service/createPublishService.dart';
import 'package:pawstic/theme.dart';

import 'model/imageFile.dart';
import 'model/specie.dart';

class Publish2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Publish2State();
}

class Publish2State extends State<Publish2> {
  File image;

  Future getImageFromGallery() async {
    final _image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      createPublishService.images.add(new ImageFile(UniqueKey(), _image));
    });
  }

  Future getImageFromCamera() async {
    final _image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      createPublishService.images.add(new ImageFile(UniqueKey(), _image));
    });
  }

  void initState() {
    super.initState();
    createPublishService.years = 1;
    createPublishService.weight = 1;
    createPublishService.images = [];
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
    super.dispose();
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 30, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          FeatherIcons.arrowLeft,
                          size: 30,
                        ),
                        tooltip: 'go back',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainWrapper(1)),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Container(
                        child: Text('Publicar anuncio',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Text('Edad (años)',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                          Spacer(),
                          Text(createPublishService.years.toString(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Slider(
                        value: createPublishService.years.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: globals.primaryColor,
                        label: createPublishService.years.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            createPublishService.years = value.toInt();
                          });
                        },
                      )),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Text('Peso (kg)',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                          Spacer(),
                          Text(createPublishService.weight.toString(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Slider(
                        value: createPublishService.weight.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: globals.primaryColor,
                        label: createPublishService.weight.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            createPublishService.weight = value.toInt();
                          });
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Text('Añadir imágenes',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                          Spacer(),
                          IconButton(
                            icon: Icon(FeatherIcons.camera),
                            color: Colors.black,
                            onPressed: () {
                              getImageFromCamera();
                            },
                          ),
                          IconButton(
                            icon: Icon(FeatherIcons.image),
                            color: Colors.black,
                            onPressed: () {
                              getImageFromGallery();
                            },
                          ),
                        ],
                      )),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10),
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      ImageFile item = createPublishService.images[i];
                      return Stack(children: [
                        ImageFileContainer(item.image),
                        Positioned(
//give the values according to your requirement
                            child: IconButton(
                          icon: Icon(FeatherIcons.x, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              createPublishService.images.removeAt(i);
                            });
                          },
                        ))
                      ]);
                    },
                    itemCount: createPublishService.images.length,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        String genderName;
                        if (Gender.macho ==
                            createPublishService.genderSelected) {
                          genderName = 'macho';
                        } else {
                          genderName = 'hembra';
                        }
                        log('Nombre: ' + createPublishService.name);
                        log('Raza: ' + createPublishService.breed);
                        log('Especie: ' +
                            createPublishService.specieSelected.name);
                        log('Genero: ' + genderName);
                        log('Color: ' + createPublishService.colorSelected);
                        http.post(
                          globals.allPublishingsUrl,
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode(<String, String>{
                            'name': createPublishService.name,
                            'years': createPublishService.years.toString(),
                            'weight': createPublishService.weight.toString(),
                            'isMale': (createPublishService.genderSelected ==
                                    Gender.macho)
                                .toString(),
                            'color': createPublishService.colorSelected,
                            'userId': 2.toString(),
                            'breed': createPublishService.breed,
                            'species': createPublishService.specieSelected.id
                                .toString(),
                            'latitude': 2.2.toString(),
                            'longitude': 6.6.toString(),
                            "likedBy": "1,2"
                          }),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainWrapper(0)),
                        );
                      },
                      label: Text(
                        "Publicar",
                        style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                            fontSize: 16.0,
                            color: globals.whiteColor),
                      ),
                      backgroundColor: globals.primaryColor,
                    ),
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/images/Publish/progressBarPublish2.png',
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
