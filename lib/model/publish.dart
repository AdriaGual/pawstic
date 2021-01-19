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
  String dateCreated;
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
      this.longitude,
      this.dateCreated);

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
        longitude = json['longitude'],
        dateCreated = json['dateCreated'];

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
      'longitude': longitude,
      'dateCreated': dateCreated
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
