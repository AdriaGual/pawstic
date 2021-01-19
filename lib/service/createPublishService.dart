import 'package:pawstic/model/imageFile.dart';
import 'package:pawstic/model/specie.dart';

enum Gender { macho, hembra }

String name;
String breed;
String colorSelected = 'negro';
Gender genderSelected = Gender.macho;
Specie specieSelected = Specie(1, "Perro");
int years = 1;
int weight = 10;
List<ImageFile> images = [];
double lastGeneratedNumber = 2;
