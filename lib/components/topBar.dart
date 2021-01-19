import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        children: [
          Icon(FeatherIcons.menu),
          Spacer(),
          SvgPicture.asset(
            'assets/images/logo.svg',
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
