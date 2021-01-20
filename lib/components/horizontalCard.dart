import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pawstic/model/publish.dart';
import 'package:pawstic/pages/details/details.dart';

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

  HorizontalCardState(this.initialPublish, this.width, this.secondWidth,
      this.heigth, this.secondHeight);

  @override
  void initState() {
    super.initState();
    publish = Publish.fromJson(initialPublish);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // When the user taps the button, show a snackbar.
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Details(publish)),
          );
        },
        child: Container(
            width: this.width,
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            alignment: Alignment.topLeft,
            child: Column(children: [
              Container(
                  width: this.width,
                  height: this.heigth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(this.publish.imageUrl.split(',')[0],
                        fit: BoxFit.cover),
                  )),
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
                    Icon(
                      FeatherIcons.heart,
                      size: 30,
                    ),
                  ]))
            ])));
  }
}
