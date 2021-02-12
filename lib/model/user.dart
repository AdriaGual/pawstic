class User {
  String sId;
  String name;
  String email;
  String password;
  int iV;
  String imageUrl;

  User(
      {this.sId, this.name, this.email, this.password, this.iV, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    iV = json['__v'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['__v'] = this.iV;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
