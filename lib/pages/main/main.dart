import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pawstic/api/publish_api.dart';
import 'package:pawstic/components/horizontalScrollVariant.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';
import 'package:pawstic/service/loadPublishService.dart';

import '../../components/horizontalScroll.dart';

class Main extends StatefulWidget {
  Main();

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<Main> {
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
                    preparePublishings(snapshot, searchText.text);
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
