import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawstic/api/user_api.dart';
import 'package:pawstic/components/textInput.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/user.dart';
import 'package:pawstic/pages/main/homeWrapper.dart';

class Profile extends StatefulWidget {
  Profile();

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  Future<User> user;
  final name = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUserLogged();
    user = fetchUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                var fetchedUser = snapshot.data;
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Stack(children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            height: 400,
                            child: Image.network(
                              fetchedUser.imageUrl,
                              fit: BoxFit.cover,
                            )),
                        Padding(
                            padding: EdgeInsets.all(30),
                            child: Row(children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                color: Colors.black,
                                icon: Icon(
                                  FeatherIcons.arrowLeft,
                                  size: 30,
                                ),
                                onPressed: () {
                                  globals.selectedIndex = 0;
                                  globals.isDrawerOpen = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeWrapper()),
                                  );
                                },
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                'assets/images/logo.svg',
                                height: 30.0,
                              ),
                            ])),
                      ]),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 260, 0, 0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 30, 30, 0),
                                      child: Column(
                                        children: [
                                          TextInput(name, fetchedUser.name,
                                              false, true),
                                          SizedBox(height: 20),
                                          TextInput(name, fetchedUser.email,
                                              false, true),
                                        ],
                                      )))))
                    ],
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(globals.primaryColor),
                    strokeWidth: 5,
                  ));
                }
              })),
    );
  }
}
