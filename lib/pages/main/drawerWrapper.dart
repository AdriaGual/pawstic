import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import "package:pawstic/globals.dart" as globals;

class DrawerWrapper extends StatefulWidget {
  @override
  DrawerWrapperState createState() => DrawerWrapperState();
}

class DrawerWrapperState extends State<DrawerWrapper> {
  List<Map> drawerItems = [
    {'icon': FeatherIcons.messageCircle, 'title': 'Mensajes'},
    {'icon': FeatherIcons.archive, 'title': 'Mis anuncios'},
    {'icon': FeatherIcons.creditCard, 'title': 'Donar'},
    {'icon': FeatherIcons.user, 'title': 'Perfil'},
    {'icon': FeatherIcons.settings, 'title': 'Configuración'},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: globals.primaryColor,
      padding: EdgeInsets.only(top: 70, bottom: 40, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: drawerItems
                .map((element) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            element['icon'],
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(element['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 18))
                        ],
                      ),
                    ))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  'Sobre nosotros',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PoppinsSemiBold',
                      fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: SvgPicture.asset(
                    'assets/images/white_logo.svg',
                    height: 30.0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
