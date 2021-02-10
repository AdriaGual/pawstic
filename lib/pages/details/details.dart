import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';
import 'package:pawstic/model/user.dart';
import 'package:pawstic/pages/main/homeWrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final Publish publish;
  Details(this.publish);

  @override
  DetailsState createState() => DetailsState(this.publish);
}

class DetailsState extends State<Details> {
  Publish publish;
  DetailsState(this.publish);
  List<String> images;
  var user;
  var userId;
  bool userLogged = false;
  List<String> likedBy = [];
  bool publishLikedByUser = false;
  var publishDate;
  String timeFromPublish = "";
  String distance = "0";
  @override
  void initState() {
    super.initState();
    images = this.publish.imageUrl.split(',');
    calculateTime();
    determinePosition();
    fetchUser();
    isUserLogged();
  }

  void calculateTime() {
    publishDate = DateTime.parse(this.publish.dateCreated);
    DateTime dateTimeNow = DateTime.now();
    final differenceInDays = dateTimeNow.difference(publishDate).inDays;
    final differenceInHours = dateTimeNow.difference(publishDate).inHours;
    final differenceInMinutes = dateTimeNow.difference(publishDate).inMinutes;
    if (differenceInDays == 0) {
      if (differenceInHours == 0) {
        if (differenceInMinutes == 0) {
          timeFromPublish = "justo ahora";
        } else {
          timeFromPublish =
              "hace " + differenceInMinutes.toString() + " minuto/s";
        }
      } else {
        timeFromPublish = "hace " + differenceInHours.toString() + " hora/s";
      }
    } else {
      timeFromPublish = "hace " + differenceInDays.toString() + " día/s";
    }
  }

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        distance = (Geolocator.distanceBetween(position.latitude,
                    position.longitude, publish.latitude, publish.longitude) /
                1000)
            .toStringAsFixed(1);
      });
    });
  }

  Future<Null> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? "";
    if (userId != "") {
      setState(() {
        userLogged = true;
        likedBy = publish.likedBy.split(",");
        publishLikedByUser = checkLikes(userId);
      });
    } else {
      userLogged = false;
    }
  }

  bool checkLikes(String userId) {
    bool likedByUser = false;

    for (String likedUser in likedBy) {
      if (likedUser == userId) likedByUser = true;
    }
    return likedByUser;
  }

  Future<Null> fetchUser() async {
    var result = await http.get(globals.allUsersUrl + publish.userId);
    setState(() {
      user = json.decode(result.body);
      user = User.fromJson(user);
    });
  }

  Future<Null> likePublish() async {
    if (!checkLikes(userId)) {
      likedBy.add(userId);
    }
    await http
        .patch(
          globals.allPublishingsUrl + publish.publishId,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'likedBy': likedBy.join(","),
          }),
        )
        .then((value) => setState(() {
              publishLikedByUser = true;
            }));
  }

  Future<Null> disLikePublish() async {
    if (checkLikes(userId)) {
      likedBy.remove(userId);
    }

    await http
        .patch(
          globals.allPublishingsUrl + publish.publishId,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'likedBy': likedBy.length != 0 ? likedBy.join(",") : "",
          }),
        )
        .then((value) => setState(() {
              publishLikedByUser = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Stack(children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 400,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: images.length,
                  layout: SwiperLayout.STACK,
                  itemWidth: 500.0,
                  itemHeight: 500.0,
                )),
            Padding(
                padding: EdgeInsets.all(30),
                child: Row(children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    color: Colors.white,
                    icon: Icon(
                      FeatherIcons.arrowLeft,
                      size: 30,
                    ),
                    onPressed: () {
                      globals.selectedIndex = 0;
                      globals.isDrawerOpen = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeWrapper()),
                      );
                    },
                  ),
                  Spacer(),
                  if (publishLikedByUser && userLogged)
                    InkWell(
                        // When the user taps the button, show a snackbar.
                        onTap: () {
                          disLikePublish();
                        },
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: globals.primaryColor,
                          size: 30,
                        ))
                  else if (!publishLikedByUser && userLogged)
                    InkWell(
                        // When the user taps the button, show a snackbar.
                        onTap: () {
                          likePublish();
                        },
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                          size: 30,
                        ))
                ])),
          ]),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 260, 0, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(publish.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  Spacer(),
                                  Icon(
                                    FontAwesomeIcons.mars,
                                    size: 30,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(publish.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                  Spacer(),
                                  Icon(
                                    FeatherIcons.mapPin,
                                    size: 20,
                                    color: globals.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('a ' + distance.toString() + ' km',
                                      style:
                                          Theme.of(context).textTheme.bodyText2)
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Column(children: [
                                    Text('Edad',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 18.0,
                                            color: globals.primaryColor)),
                                    if (publish.years == 1)
                                      Text(publish.years.toString() + ' año',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsSemiBold',
                                              fontSize: 18.0,
                                              color: globals.titleColor))
                                    else
                                      Text(publish.years.toString() + ' años',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsSemiBold',
                                              fontSize: 18.0,
                                              color: globals.titleColor)),
                                  ]),
                                  Spacer(),
                                  Column(children: [
                                    Text('Peso',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 18.0,
                                            color: globals.primaryColor)),
                                    Text(publish.weight.toString() + 'kg',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsSemiBold',
                                            fontSize: 18.0,
                                            color: globals.titleColor)),
                                  ]),
                                  Spacer(),
                                  Column(children: [
                                    Text('Color',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 18.0,
                                            color: globals.primaryColor)),
                                    Text(
                                        publish.color[0].toUpperCase() +
                                            publish.color.substring(1),
                                        style: TextStyle(
                                            fontFamily: 'PoppinsSemiBold',
                                            fontSize: 18.0,
                                            color: globals.titleColor)),
                                  ]),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.asset(
                                    'assets/images/onBoarding/onBoarding3.png',
                                    width: 60.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (user != null)
                                        Text(user.name,
                                            style: TextStyle(
                                                fontFamily: 'PoppinsSemiBold',
                                                fontSize: 16.0,
                                                color: globals.titleColor)),
                                      Text(timeFromPublish,
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14.0,
                                              color: globals.bodyColor)),
                                    ]),
                              ]),
                              SizedBox(height: 20),
                              Row(children: [
                                Spacer(),
                                SizedBox(
                                  width: 200.0,
                                  height: 60.0,
                                  child: FloatingActionButton.extended(
                                    heroTag: "btn1",
                                    onPressed: () {},
                                    label: Text(
                                      "Adoptar",
                                      style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16.0,
                                          color: globals.whiteColor),
                                    ),
                                    backgroundColor: globals.primaryColor,
                                  ),
                                ),
                                Spacer(),
                                FloatingActionButton(
                                  heroTag: "btn2",
                                  onPressed: () {},
                                  child: Icon(FeatherIcons.upload),
                                  backgroundColor: globals.primaryColor,
                                ),
                                Spacer(),
                              ]),
                              SizedBox(height: 10),
                            ],
                          )))))
        ],
      )),
    );
  }
}
