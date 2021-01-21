import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawstic/components/drawerItem.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/login/login.dart';

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
            children: [
              InkWell(
                  onTap: () {
                    globals.isDrawerOpen = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: DrawerItem('Iniciar sesión', FeatherIcons.logIn))
            ],
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
