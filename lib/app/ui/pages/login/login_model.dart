// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String status;
  final String data;
  final int id;
  final String username;

  LoginModel({
    required this.status,
    required this.data,
    required this.id,
    required this.username,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json["data"],
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "id": id,
        "username": username,
      };
}
