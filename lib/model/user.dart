class User {
  String userId;
  String name;
  String email;
  String imageUrl;
  User(
    this.userId,
    this.name,
    this.email,
    this.imageUrl,
  );

  User.fromJson(Map json)
      : userId = json['_id'],
        name = json['name'],
        email = json['email'],
        imageUrl = json['imageUrl'];

  Map toJson() {
    return {'_id': userId, 'name': name, 'email': email, 'imageUrl': imageUrl};
  }
}
