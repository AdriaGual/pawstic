String calculateTime(String dateCreated) {
  var publishDate = DateTime.parse(dateCreated);
  DateTime dateTimeNow = DateTime.now();
  final differenceInDays = dateTimeNow.difference(publishDate).inDays;
  final differenceInHours = dateTimeNow.difference(publishDate).inHours;
  final differenceInMinutes = dateTimeNow.difference(publishDate).inMinutes;
  var timeFromPublish;
  if (differenceInDays == 0) {
    if (differenceInHours == 0) {
      if (differenceInMinutes == 0) {
        timeFromPublish = "justo ahora";
      } else {
        timeFromPublish =
            "hace " + differenceInMinutes.toString() + " minuto/s";
      }
    } else {
      timeFromPublish = "hace " + differenceInHours.toString() + " hora/s";
    }
  } else {
    timeFromPublish = "hace " + differenceInDays.toString() + " día/s";
  }
  return timeFromPublish;
}
