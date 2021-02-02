import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';
import 'package:pawstic/pages/details/details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HorizontalCard extends StatefulWidget {
  final Map initialPublish;
  final double width;
  final double secondWidth;
  final double secondHeight;
  final double heigth;
  HorizontalCard(this.initialPublish, this.width, this.secondWidth, this.heigth,
      this.secondHeight);

  @override
  State<StatefulWidget> createState() => HorizontalCardState(
      this.initialPublish,
      this.width,
      this.secondWidth,
      this.heigth,
      this.secondHeight);
}

class HorizontalCardState extends State<HorizontalCard> {
  Map initialPublish;
  double width;
  double secondWidth;
  double secondHeight;
  double heigth;
  Publish publish;
  bool userLogged = false;
  var userId;
  List<String> likedBy = [];
  bool publishLikedByUser = false;
  HorizontalCardState(this.initialPublish, this.width, this.secondWidth,
      this.heigth, this.secondHeight);

  @override
  void initState() {
    super.initState();
    publish = Publish.fromJson(initialPublish);
    isUserLogged();
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

  Future<Null> likePublish() async {
    if (!checkLikes(userId)) {
      likedBy.add(userId);
    }
    await http.patch(
      globals.allPublishingsUrl + publish.publishId,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'likedBy': likedBy.join(","),
      }),
    );
    setState(() {
      publishLikedByUser = true;
    });
  }

  Future<Null> disLikePublish() async {
    if (checkLikes(userId)) {
      likedBy.remove(userId);
    }

    await http.patch(
      globals.allPublishingsUrl + publish.publishId,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'likedBy': likedBy.length != 0 ? likedBy.join(",") : "",
      }),
    );

    setState(() {
      publishLikedByUser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
        alignment: Alignment.topLeft,
        child: Column(children: [
          InkWell(
              // When the user taps the button, show a snackbar.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(publish)),
                );
              },
              child: Container(
                  width: this.width,
                  height: this.heigth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(this.publish.imageUrl.split(',')[0],
                        fit: BoxFit.cover),
                  ))),
          Container(
              width: this.width,
              height: this.secondHeight, //80.0,
              child: Row(children: [
                Container(
                    width: this.secondWidth,
                    child: Column(children: [
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 13, 10, 0),
                          child: Text(this.publish.name,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        if (this.publish.isMale)
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: FaIcon(FontAwesomeIcons.mars),
                          )
                        else
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: FaIcon(FontAwesomeIcons.venus),
                          )
                      ]),
                      if (this.publish.years != 1)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              this.publish.breed +
                                  ', ' +
                                  this.publish.years.toString() +
                                  ' años',
                              style: Theme.of(context).textTheme.subtitle2),
                        )
                      else
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              this.publish.breed +
                                  ', ' +
                                  this.publish.years.toString() +
                                  ' año',
                              style: Theme.of(context).textTheme.subtitle2),
                        )
                    ])),
                if (publishLikedByUser)
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
                else
                  InkWell(
                      // When the user taps the button, show a snackbar.
                      onTap: () {
                        likePublish();
                      },
                      child: Icon(
                        FontAwesomeIcons.heart,
                        size: 30,
                      ))
              ]))
        ]));
  }
}
