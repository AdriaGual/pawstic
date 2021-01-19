import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pawstic/globals.dart" as globals;

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        cursorColor: globals.primaryColor,
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
    );
  }
}
