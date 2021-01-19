import 'dart:io';

import 'package:pawstic/model/specie.dart';

enum Gender { macho, hembra }

String name;
String breed;
String colorSelected = 'negro';
Gender genderSelected = Gender.macho;
Specie specieSelected = Specie(1, "Perro");
int years = 1;
int weight = 10;
List<File> images = [];
List<String> imagesUploaded = [];
double lastGeneratedNumber = 2;
double latitude = 0;
double longitude = 0;

void clear() {
  name = "";
  breed = "";
  colorSelected = 'negro';
  genderSelected = Gender.macho;
  specieSelected = Specie(1, "Perro");
  years = 1;
  weight = 10;
  images = [];
  imagesUploaded = [];
  lastGeneratedNumber = 2;
  latitude = 0;
  longitude = 0;
}
