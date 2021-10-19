// To parse this JSON data, do
//
//     final validateTokenModel = validateTokenModelFromJson(jsonString);

import 'dart:convert';

ValidateTokenModel validateTokenModelFromJson(String str) => ValidateTokenModel.fromJson(json.decode(str));

String validateTokenModelToJson(ValidateTokenModel data) => json.encode(data.toJson());

class ValidateTokenModel {
  ValidateTokenModel({
    this.success,
    this.login,
    this.message,
  });

  bool? success;
  bool? login;
  String? message;

  factory ValidateTokenModel.fromJson(Map<String, dynamic> json) => ValidateTokenModel(
    success: json["success"],
    login: json["login"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "login": login,
    "message": message,
  };
}
