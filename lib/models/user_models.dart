import 'dart:convert';

User userFromJson(String str) => User.fronJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String? id;
  String? email;
  String? name;
  String? last_name;
  String? phone;
  String? password;
  String? proyecto_id;
  String? role_id;
  String? session_token;

  User({
    this.id,
    this.email,
    this.name,
    this.last_name,
    this.phone,
    this.password,
    this.proyecto_id,
    this.role_id,
    this.session_token
  });

  factory User.fronJson(Map<String, dynamic> json) => User(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      last_name: json["last_name"],
      phone: json["phone"],
      password: json["password"],
      proyecto_id: json["proyecto_id"],
      role_id: json["role_id"],
      session_token: json["session_token"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "last_name": last_name,
    "phone": phone,
    "password": password,
    "proyecto_id": proyecto_id,
    "role_id": role_id,
    "session_token": session_token
  };

}
