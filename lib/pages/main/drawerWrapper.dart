import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawstic/components/drawerItem.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/pages/login/login.dart';
import 'package:pawstic/pages/myPublishings/myPublishings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homeWrapper.dart';

class DrawerWrapper extends StatefulWidget {
  @override
  DrawerWrapperState createState() => DrawerWrapperState();
}

class DrawerWrapperState extends State<DrawerWrapper> {
  bool userLogged = false;

  List<Map> drawerItems = [
    {'icon': FeatherIcons.messageCircle, 'title': 'Mensajes'},
    {'icon': FeatherIcons.archive, 'title': 'Mis anuncios'},
    {'icon': FeatherIcons.creditCard, 'title': 'Donar'},
    {'icon': FeatherIcons.user, 'title': 'Perfil'},
    {'icon': FeatherIcons.settings, 'title': 'Configuración'},
  ];

  @override
  void initState() {
    super.initState();
    isUserLogged();
  }

  Future<Null> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? "";
    if (userId != "") {
      setState(() {
        userLogged = true;
      });
    } else {
      userLogged = false;
    }
  }

  Future<Null> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');

    globals.isDrawerOpen = false;
    globals.selectedIndex = 0;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeWrapper()),
    );
  }

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
              if (!userLogged)
                InkWell(
                    onTap: () {
                      globals.isDrawerOpen = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: DrawerItem('Iniciar sesión', FeatherIcons.logIn)),
              if (userLogged)
                InkWell(
                    onTap: () {
                      globals.isDrawerOpen = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: DrawerItem('Mensajes', FeatherIcons.messageCircle)),
              if (userLogged)
                InkWell(
                    onTap: () {
                      globals.isDrawerOpen = false;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyPublishings()),
                      );
                    },
                    child: DrawerItem('Mis anuncios', FeatherIcons.archive)),
              if (userLogged)
                InkWell(
                    onTap: () {
                      globals.isDrawerOpen = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: DrawerItem('Perfil', FeatherIcons.user)),
              if (userLogged)
                InkWell(
                    onTap: () {
                      logOut();
                    },
                    child: DrawerItem('Cerrar sesión', FeatherIcons.logOut))
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
