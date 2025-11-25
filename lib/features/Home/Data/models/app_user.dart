class UserModel {
  String? username;
  String? id;
  String? email;
  String? password;
  UserModel({this.username, this.id, this.email, this.password});

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        email: json["email"],
        id: json["id"],
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
      "password": password,
      "username": username,
    };
  }
}