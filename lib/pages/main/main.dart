import 'package:flutter/material.dart';
import 'package:pawstic/components/horizontalScrollVariant.dart';

import '../../components/filterBreed.dart';
import '../../components/horizontalScroll.dart';
import '../../components/searchBar.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SearchBar(),
          FilterBreed(),
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
      ),
    ));
  }
}
