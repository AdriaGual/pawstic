import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userId;
bool userLogged = false;

User parseUser(String responseBody) {
  var userJson = json.decode(responseBody);
  User user = User.fromJson(userJson);
  return user;
}

Future<User> fetchUser(String userId) async {
  final response = await http.get(globals.allUsersUrl + userId);
  if (response.statusCode == 200) {
    return compute(parseUser, response.body);
  } else {
    throw Exception('Request API Error');
  }
}

Future<Null> isUserLogged() async {
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId') ?? "";
  if (userId != "") {
    userLogged = true;
  } else {
    userLogged = false;
  }
}
