import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pawstic/components/imageFileContainer.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/specie.dart';
import 'package:pawstic/pages/main/homeWrapper.dart';
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;
import 'package:pawstic/service/createPublishService.dart';
import 'package:pawstic/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Publish2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Publish2State();
}

class Publish2State extends State<Publish2> {
  var userId;

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

  Future getImageFromGallery() async {
    PickedFile selectedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 25);
    File _image = File(selectedFile.path);

    setState(() {
      createPublishService.images.add(_image);
    });
  }

  Future getImageFromCamera() async {
    PickedFile selectedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 25);
    File _image = File(selectedFile.path);

    setState(() {
      createPublishService.images.add(_image);
    });
  }

  Future<Null> getCurrentLocation() async {
    Future getFuture() {
      return Future(() async {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          setState(() {
            createPublishService.latitude = position.latitude;
            createPublishService.longitude = position.longitude;
          });
          uploadImage();
        }).catchError((e) {
          print(e);
        });
      });
    }

    await showDialog(
        context: context,
        child: FutureProgressDialog(
          getFuture(),
        ));
  }

  Future<Null> uploadImage() async {
    for (File image in createPublishService.images) {
      var cloudinary =
          CloudinaryPublic('drws2krnb', 'uploadImage', cache: false);
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      createPublishService.imagesUploaded.add(response.secureUrl);
    }
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? "";
    createPublish();
  }

  void createPublish() {
    http.post(
      globals.allPublishingsUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': createPublishService.name,
        'years': createPublishService.years.toString(),
        'weight': createPublishService.weight.toString(),
        'isMale':
            (createPublishService.genderSelected == Gender.macho).toString(),
        'color': createPublishService.colorSelected,
        'userId': userId,
        'breed': createPublishService.breed,
        'species': createPublishService.specieSelected.id.toString(),
        'latitude': createPublishService.latitude.toString(),
        'longitude': createPublishService.longitude.toString(),
        'imageUrl': createPublishService.imagesUploaded.join(","),
        "likedBy": "1,2"
      }),
    );
    createPublishService.clear();
    globals.selectedIndex = 0;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeWrapper()),
    );
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
              padding: EdgeInsets.fromLTRB(0, 25, 0, 30),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 30, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          FeatherIcons.arrowLeft,
                          size: 30,
                        ),
                        onPressed: () {
                          globals.selectedIndex = 1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeWrapper()),
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
                  if (createPublishService.images.isNotEmpty)
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10),
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int i) {
                        File item = createPublishService.images[i];
                        return Stack(children: [
                          ImageFileContainer(item),
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
                        getCurrentLocation();
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
