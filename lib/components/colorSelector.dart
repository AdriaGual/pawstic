import 'package:flutter/material.dart';
import "package:pawstic/globals.dart" as globals;
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;

class ColorSelector extends StatefulWidget {
  ColorSelector();

  @override
  State<StatefulWidget> createState() => ColorSelectorState();
}

class ColorSelectorState extends State<ColorSelector> {
  ColorSelectorState();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: InkWell(
              onTap: () {
                setState(() {
                  createPublishService.colorSelected = 'negro';
                });
              }, // handle your onTap here
              child: Container(
                  height: 42.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: createPublishService.colorSelected == 'negro'
                            ? globals.primaryColor
                            : Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))))),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: InkWell(
              onTap: () {
                setState(() {
                  createPublishService.colorSelected = 'marron';
                });
              }, // handle your onTap here
              child: Container(
                  height: 42.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                      color: globals.brownColor,
                      border: Border.all(
                        color: createPublishService.colorSelected == 'marron'
                            ? globals.primaryColor
                            : Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))))),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: InkWell(
              onTap: () {
                setState(() {
                  createPublishService.colorSelected = 'gris';
                });
              }, // handle your onTap here
              child: Container(
                  height: 42.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                      color: globals.greyColor_2,
                      border: Border.all(
                        color: createPublishService.colorSelected == 'gris'
                            ? globals.primaryColor
                            : Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))))),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: InkWell(
              onTap: () {
                setState(() {
                  createPublishService.colorSelected = 'beige';
                });
              }, // handle your onTap here
              child: Container(
                  height: 42.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                      color: globals.beigeColor,
                      border: Border.all(
                        color: createPublishService.colorSelected == 'beige'
                            ? globals.primaryColor
                            : Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))))),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: InkWell(
              onTap: () {
                setState(() {
                  createPublishService.colorSelected = 'meat';
                });
              }, // handle your onTap here
              child: Container(
                  height: 42.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                      color: globals.meatColor,
                      border: Border.all(
                        color: createPublishService.colorSelected == 'meat'
                            ? globals.primaryColor
                            : Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))))),
    ]);
  }
}
