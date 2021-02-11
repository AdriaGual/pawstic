import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/publish.dart';

List<Publish> parsePublish(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Publish> publishings =
      list.map((model) => Publish.fromJson(model)).toList();
  return publishings;
}

Future<List<Publish>> fetchPublishings() async {
  final response = await http.get(globals.allPublishingsUrl);
  if (response.statusCode == 200) {
    return compute(parsePublish, response.body);
  } else {
    throw Exception('Request API Error');
  }
}
