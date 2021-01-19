import 'dart:io';

import 'package:flutter/material.dart';

class ImageFileContainer extends StatelessWidget {
  File item;
  ImageFileContainer(this.item);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.file(
          item,
          height: 110,
          width: 200,
          fit: BoxFit.cover,
        ));
  }
}
