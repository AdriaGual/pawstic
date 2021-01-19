import 'dart:async';

import 'package:http/http.dart' as http;
import "package:pawstic/globals.dart" as globals;

const baseUrl = "https://jsonplaceholder.typicode.com";

class API {
  static Future getPublishings() {
    var url = globals.allPublishingsUrl;
    return http.get(url);
  }
}
