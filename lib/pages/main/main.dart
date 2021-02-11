import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pawstic/api/publish_api.dart';
import 'package:pawstic/components/horizontalScrollVariant.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';

import '../../components/horizontalScroll.dart';

class Main extends StatefulWidget {
  Main();

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<Main> {
  List<int> selectedSpecies = [];
  double currentDistance;
  Future<List<Publish>> publishings;
  final searchText = TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedSpecies = [];
    publishings = fetchPublishings(false);
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
    setState(() {});
  }

  filterBySpecies() {
    if (selectedSpecies.isNotEmpty) {
      List<dynamic> filteredUrgentPublishings = [];
      for (var publish in globals.urgentPublishings) {
        if (selectedSpecies.contains(publish.species)) {
          filteredUrgentPublishings.add(publish);
        }
      }

      List<dynamic> filteredOtherPublishings = [];
      for (var publish in globals.otherPublishings) {
        if (selectedSpecies.contains(publish.species)) {
          filteredOtherPublishings.add(publish);
        }
      }

      globals.urgentPublishings = filteredUrgentPublishings;
      globals.otherPublishings = filteredOtherPublishings;
    } else {
      globals.urgentPublishings = globals.initialUrgentPublishings;
      globals.otherPublishings = globals.initialOtherPublishings;
    }
  }

  filterPublishings(String text) {
    if (text.isNotEmpty) {
      List<dynamic> filteredUrgentPublishings = [];
      List<dynamic> filteredOtherPublishings = [];
      for (var publish in globals.urgentPublishings) {
        if (publish.name.contains(text)) {
          filteredUrgentPublishings.add(publish);
        }
      }

      for (var publish in globals.otherPublishings) {
        if (publish.name.contains(text)) {
          filteredOtherPublishings.add(publish);
        }
      }

      globals.urgentPublishings = filteredUrgentPublishings;
      globals.otherPublishings = filteredOtherPublishings;
    } else if (selectedSpecies.isEmpty) {
      globals.urgentPublishings = globals.initialUrgentPublishings;
      globals.otherPublishings = globals.initialOtherPublishings;
    }
  }

  void preparePublishings(AsyncSnapshot snapshot) {
    globals.publishings = [];
    globals.urgentPublishings = [];
    globals.otherPublishings = [];
    globals.publishings = snapshot.data;
    globals.publishings.sort((a, b) =>
        DateTime.parse(a.dateCreated).compareTo(DateTime.parse(b.dateCreated)));
    splitPublishings();
  }

  void splitPublishings() async {
    if (globals.publishings.length > 3) {
      for (var a in globals.publishings) {
        globals.urgentPublishings.add(a);
        globals.otherPublishings.add(a);
      }
      globals.urgentPublishings
          .removeRange(3, globals.urgentPublishings.length);
      globals.otherPublishings.removeRange(0, 3);
    }
    sortPublishings();
  }

  void sortPublishings() {
    if (globals.position != null) {
      globals.initialOtherPublishings = [];
      for (var a in globals.otherPublishings) {
        double distanceInMeters = Geolocator.distanceBetween(
            globals.position.latitude,
            globals.position.longitude,
            a.latitude,
            a.longitude);
        a.distance = distanceInMeters;
        globals.initialOtherPublishings.add(a);
      }
      globals.initialOtherPublishings
          .sort((a, b) => a.distance.compareTo(b.distance));
      globals.otherPublishings = globals.initialOtherPublishings;
    }

    globals.initialUrgentPublishings = globals.urgentPublishings;
    filterBySpecies();
    filterPublishings(searchText.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              cursorColor: globals.primaryColor,
              controller: searchText,
              onChanged: (text) {
                setState(() {});
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
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: Row(
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
          ),
          FutureBuilder(
              future: publishings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("API Error");
                  } else {
                    preparePublishings(snapshot);
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              child: Text('Urgente',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ),
                        ),
                        HorizontalScroll(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              child: Text('Cercanos',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ),
                        ),
                        HorizontalScrollVariant(),
                      ],
                    );
                  }
                } else {
                  return SizedBox(
                      height: 500.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              globals.primaryColor),
                          strokeWidth: 5,
                        ),
                      ));
                }
              }),
        ],
      ),
    ));
  }
}
