import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';
import 'package:pawstic/pages/main/homeWrapper.dart';

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
  @override
  void initState() {
    super.initState();
    log(publish.name);
    images = this.publish.imageUrl.split(',');
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
                  itemWidth: 400.0,
                  itemHeight: 400.0,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeWrapper()),
                      );
                    },
                  ),
                  Spacer(),
                  IconButton(
                    constraints: BoxConstraints(),
                    color: Colors.white,
                    icon: Icon(
                      FeatherIcons.heart,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ])),
          ]),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 340, 0, 0),
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
                                  Text('a 1.5 km',
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
                                      Text('Dianne Russell',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsSemiBold',
                                              fontSize: 16.0,
                                              color: globals.titleColor)),
                                      Text('Dueña',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14.0,
                                              color: globals.bodyColor)),
                                    ]),
                                Spacer(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('hace 3 dias',
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14.0,
                                              color: globals.bodyColor)),
                                    ])
                              ]),
                              SizedBox(height: 20),
                              Row(children: [
                                Spacer(),
                                SizedBox(
                                  width: 200.0,
                                  height: 60.0,
                                  child: FloatingActionButton.extended(
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
                                  onPressed: () {},
                                  child: Icon(FeatherIcons.upload),
                                  backgroundColor: globals.primaryColor,
                                ),
                                Spacer(),
                              ])
                            ],
                          )))))
        ],
      )),
    );
  }
}
