import 'package:flutter/cupertino.dart';
import "package:pawstic/globals.dart" as globals;

List<int> selectedSpecies = [];

filterBySpecies() {
  if (selectedSpecies.isNotEmpty) {
    List<dynamic> filteredUrgentPublishings = [];
    for (var publish in globals.urgentPublishings) {
      if (selectedSpecies.contains(publish.species)) {
        filteredUrgentPublishings.add(publish);
      }
    }

    List<dynamic> filteredOtherPublishings = [];
    for (var publish in globals.otherPublishings) {
      if (selectedSpecies.contains(publish.species)) {
        filteredOtherPublishings.add(publish);
      }
    }

    globals.urgentPublishings = filteredUrgentPublishings;

    globals.otherPublishings = filteredOtherPublishings;
  } else {
    if (globals.initialUrgentPublishings.isNotEmpty) {
      globals.urgentPublishings = globals.initialUrgentPublishings;
    }
    if (globals.initialOtherPublishings.isNotEmpty) {
      globals.otherPublishings = globals.initialOtherPublishings;
    }
  }
}

filterPublishings(String text) {
  if (text.isNotEmpty) {
    List<dynamic> filteredUrgentPublishings = [];
    List<dynamic> filteredOtherPublishings = [];
    for (var publish in globals.urgentPublishings) {
      if (publish.name.contains(text)) {
        filteredUrgentPublishings.add(publish);
      }
    }

    for (var publish in globals.otherPublishings) {
      if (publish.name.contains(text)) {
        filteredOtherPublishings.add(publish);
      }
    }

    globals.urgentPublishings = filteredUrgentPublishings;
    globals.otherPublishings = filteredOtherPublishings;
  } else if (selectedSpecies.isEmpty) {
    if (globals.initialUrgentPublishings.isNotEmpty) {
      globals.urgentPublishings = globals.initialUrgentPublishings;
    }
    if (globals.initialOtherPublishings.isNotEmpty) {
      globals.otherPublishings = globals.initialOtherPublishings;
    }
  }
}

void preparePublishings(AsyncSnapshot snapshot, String filterText) {
  globals.publishings = [];
  globals.urgentPublishings = [];
  globals.otherPublishings = [];
  globals.publishings = snapshot.data;
  globals.publishings.sort((a, b) =>
      DateTime.parse(a.dateCreated).compareTo(DateTime.parse(b.dateCreated)));
  splitPublishings();
  sortPublishings(filterText);
}

void splitPublishings() async {
  if (globals.publishings.length > 3) {
    for (var a in globals.publishings) {
      globals.urgentPublishings.add(a);
      globals.otherPublishings.add(a);
    }
    globals.urgentPublishings.removeRange(3, globals.urgentPublishings.length);
    globals.otherPublishings.removeRange(0, 3);
  }
}

void sortPublishings(String filterText) {
  /*if (globals.position != null) {
    globals.initialOtherPublishings = [];
    for (var a in globals.otherPublishings) {
      double distanceInMeters = Geolocator.distanceBetween(
          globals.position.latitude,
          globals.position.longitude,
          a.latitude,
          a.longitude);
      a.distance = distanceInMeters;
      globals.initialOtherPublishings.add(a);
    }
    globals.initialOtherPublishings
        .sort((a, b) => a.distance.compareTo(b.distance));
    globals.otherPublishings = globals.initialOtherPublishings;
  }*/

  globals.initialUrgentPublishings = globals.urgentPublishings;
  filterBySpecies();
  filterPublishings(filterText);
}
