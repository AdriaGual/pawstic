import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pawstic/components/horizontalCard.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/service/loadPublishService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Likes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LikesState();
}

class LikesState extends State<Likes> {
  bool userLogged = false;
  final searchText = TextEditingController();
  var userId;
  List<dynamic> likedPublishings = [];
  List<dynamic> initialLikedPublishings = [];
  void initState() {
    super.initState();
    isUserLogged();
  }

  filterBreed(int n) {
    if (!selectedSpecies.contains(n)) {
      setState(() {
        selectedSpecies.add(n);
      });
    } else {
      setState(() {
        selectedSpecies.remove(n);
      });
    }
    filterByName(searchText.text);
    filterSpecies();
  }

  void filterSpecies() {
    List<dynamic> filteredPublishings = [];
    if (selectedSpecies.isNotEmpty) {
      for (var publish in likedPublishings) {
        if (selectedSpecies.contains(publish.species)) {
          filteredPublishings.add(publish);
        }
      }
      setState(() {
        likedPublishings = filteredPublishings;
      });
    } else if (searchText.text.isEmpty && selectedSpecies.isEmpty) {
      setState(() {
        likedPublishings = initialLikedPublishings;
      });
    }
  }

  void filterByName(String text) {
    setState(() {
      likedPublishings = initialLikedPublishings;
    });
    if (text.isNotEmpty) {
      List<dynamic> filteredPublishings = [];
      for (var publish in likedPublishings) {
        if (publish.name.contains(text)) {
          filteredPublishings.add(publish);
        }
      }
      setState(() {
        likedPublishings = filteredPublishings;
      });
    }
  }

  void filterByLiked() {
    if (globals.publishings.isNotEmpty) {
      likedPublishings = [];
      for (var publish in globals.publishings) {
        if (checkLikes(userId, publish.likedBy.split(","))) {
          likedPublishings.add(publish);
        }
      }
      initialLikedPublishings = likedPublishings;
    }
  }

  bool checkLikes(String userId, List<String> likedBy) {
    bool likedByUser = false;

    for (String likedUser in likedBy) {
      if (likedUser == userId) likedByUser = true;
    }
    return likedByUser;
  }

  Future<Null> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? "";
    if (userId != "") {
      setState(() {
        userLogged = true;
      });
      filterByLiked();
    } else {
      userLogged = false;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Me gusta',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            cursorColor: globals.primaryColor,
            controller: searchText,
            onChanged: (text) {
              filterByName(text);
              filterSpecies();
            },
            style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 17.0,
                color: globals.titleColor),
            decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 17.0,
                    color: globals.greyColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                  child: Icon(
                    FeatherIcons.search,
                    color: globals.titleColor,
                  ),
                ),
                filled: true,
                fillColor: globals.fillGreyColor),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    filterBreed(1);
                  },
                  child: Text('Perros',
                      style: TextStyle(
                          fontFamily: !selectedSpecies.contains(1)
                              ? 'PoppinsMedium'
                              : 'PoppinsBold',
                          fontSize: 16.0,
                          color: globals.bodyColor))),
              Spacer(),
              InkWell(
                  onTap: () {
                    filterBreed(2);
                  },
                  child: Text('Gatos',
                      style: TextStyle(
                          fontFamily: !selectedSpecies.contains(2)
                              ? 'PoppinsMedium'
                              : 'PoppinsBold',
                          fontSize: 16.0,
                          color: globals.bodyColor))),
              Spacer(),
              InkWell(
                  onTap: () {
                    filterBreed(3);
                  },
                  child: Text('Conejos',
                      style: TextStyle(
                          fontFamily: !selectedSpecies.contains(3)
                              ? 'PoppinsMedium'
                              : 'PoppinsBold',
                          fontSize: 16.0,
                          color: globals.bodyColor))),
              Spacer(),
              InkWell(
                  onTap: () {
                    filterBreed(4);
                  },
                  child: Text('Pájaros',
                      style: TextStyle(
                          fontFamily: !selectedSpecies.contains(4)
                              ? 'PoppinsMedium'
                              : 'PoppinsBold',
                          fontSize: 16.0,
                          color: globals.bodyColor))),
              Spacer(),
              InkWell(
                  onTap: () {
                    filterBreed(5);
                  },
                  child: Text('Otros',
                      style: TextStyle(
                          fontFamily: !selectedSpecies.contains(5)
                              ? 'PoppinsMedium'
                              : 'PoppinsBold',
                          fontSize: 16.0,
                          color: globals.bodyColor))),
            ],
          ),
          SizedBox(height: 20),
          if (likedPublishings.isNotEmpty)
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.7 / 3,
                ),
                itemCount: likedPublishings.length,
                itemBuilder: (BuildContext ctx, index) {
                  return HorizontalCard(
                      likedPublishings[index], 300.0, 115.0, 200.0, 70.0);
                })
          else
            SizedBox(
                height: 400.0,
                child: Center(
                  child: Text("No hay publicaciones actualmente 🙀"),
                ))
        ],
      ),
    )));
  }
}
