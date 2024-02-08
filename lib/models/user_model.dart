// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String username;
  String email;
  String uid;

  UserModel({
    required this.username,
    required this.email,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    email: json["email"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "uid": uid,
  };
}
