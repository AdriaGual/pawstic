import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;

class ImageFileContainer extends StatefulWidget {
  File item;

  ImageFileContainer(this.item);

  @override
  State<StatefulWidget> createState() => ImageFileContainerState(this.item);
}

class ImageFileContainerState extends State<ImageFileContainer> {
  File item;

  ImageFileContainerState(this.item);

  double generatedNumber;

  void initState() {
    super.initState();
    createPublishService.lastGeneratedNumber % 2 == 0
        ? generatedNumber = generateRandomNumber()
        : generatedNumber = 100 - createPublishService.lastGeneratedNumber;
  }

  double generateRandomNumber() {
    var random = new Random();
    return (random.nextInt(100) + 100).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.file(
            item,
            height: 110,
            width: generatedNumber,
            fit: BoxFit.cover,
          )),
    );
  }
}
