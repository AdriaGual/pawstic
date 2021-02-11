class Publish {
  String sId;
  String name;
  int years;
  int weight;
  bool isMale;
  String color;
  String imageUrl;
  String userId;
  String breed;
  int species;
  double latitude;
  double longitude;
  String dateCreated;
  String likedBy;
  int iV;
  double distance = 0.0;
  Publish(
      {this.sId,
      this.name,
      this.years,
      this.weight,
      this.isMale,
      this.color,
      this.imageUrl,
      this.userId,
      this.breed,
      this.species,
      this.latitude,
      this.longitude,
      this.dateCreated,
      this.likedBy,
      this.iV});

  Publish.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    years = json['years'];
    weight = json['weight'];
    isMale = json['isMale'];
    color = json['color'];
    imageUrl = json['imageUrl'];
    userId = json['userId'];
    breed = json['breed'];
    species = json['species'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    dateCreated = json['dateCreated'];
    likedBy = json['likedBy'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['years'] = this.years;
    data['weight'] = this.weight;
    data['isMale'] = this.isMale;
    data['color'] = this.color;
    data['imageUrl'] = this.imageUrl;
    data['userId'] = this.userId;
    data['breed'] = this.breed;
    data['species'] = this.species;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['dateCreated'] = this.dateCreated;
    data['likedBy'] = this.likedBy;
    data['__v'] = this.iV;
    return data;
  }
}
