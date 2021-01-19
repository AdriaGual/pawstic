import 'dart:convert';

import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/service/webService.dart';

class Publish {
  String publishId;
  String name;
  int years;
  int weight;
  bool isMale;
  String color;
  String imageUrl;
  int userId;
  String breed;
  int species;
  double latitude;
  double longitude;
  Publish(
      this.publishId,
      this.name,
      this.years,
      this.weight,
      this.isMale,
      this.color,
      this.species,
      this.breed,
      this.imageUrl,
      this.userId,
      this.latitude,
      this.longitude);

  /*factory Publish.fromJson(Map<String, dynamic> json) {


    return Publish(
      json['_id'],
      json['name'],
      json['years'],
      json['weight'],
      json['isMale'],
      json['color'],
      json['species'],
      json['breed'],
      json['imageUrl'],
      json['userId'],
      json['latitude'],
      json['longitude'],
    );
  }*/

  Publish.fromJson(Map json)
      : publishId = json['_id'],
        name = json['name'],
        years = json['years'],
        weight = json['weight'],
        isMale = json['isMale'],
        color = json['color'],
        species = json['species'],
        breed = json['breed'],
        imageUrl = json['imageUrl'],
        userId = json['userId'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map toJson() {
    return {
      '_id': publishId,
      'name': name,
      'years': years,
      'weight': weight,
      'isMale': isMale,
      'color': color,
      'species': species,
      'breed': breed,
      'imageUrl': imageUrl,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  static Resource<List<Publish>> get all {
    return Resource(
        url: globals.allPublishingsUrl,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Publish.fromJson(model)).toList();
        });
  }
}
