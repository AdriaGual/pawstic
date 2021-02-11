import 'package:geolocator/geolocator.dart';
import "package:pawstic/globals.dart" as globals;

void getPosition() async {
  if (globals.position == null) {
    globals.position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
