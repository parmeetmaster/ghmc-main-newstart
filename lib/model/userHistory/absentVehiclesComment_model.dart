// To parse this JSON data, do
//
//     final absentVehiclesComment = absentVehiclesCommentFromJson(jsonString);

import 'dart:convert';

AbsentVehiclesComment absentVehiclesCommentFromJson(String str) => AbsentVehiclesComment.fromJson(json.decode(str));

String absentVehiclesCommentToJson(AbsentVehiclesComment data) => json.encode(data.toJson());

class AbsentVehiclesComment {
  AbsentVehiclesComment({
    this.success,
    this.login,
    this.message,
  });

  bool? success;
  bool? login;
  String? message;

  factory AbsentVehiclesComment.fromJson(Map<String, dynamic> json) => AbsentVehiclesComment(
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
