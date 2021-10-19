// To parse this JSON data, do
//
//     final gvpBepTripsModel = gvpBepTripsModelFromJson(jsonString);

import 'dart:convert';

GvpBepTripsModel gvpBepTripsModelFromJson(String str) =>
    GvpBepTripsModel.fromJson(json.decode(str));

String gvpBepTripsModelToJson(GvpBepTripsModel data) =>
    json.encode(data.toJson());

class GvpBepTripsModel {
  GvpBepTripsModel({
    this.success,
    this.login,
    this.message,
  });

  bool? success;
  bool? login;
  String? message;

  factory GvpBepTripsModel.fromJson(Map<String, dynamic> json) =>
      GvpBepTripsModel(
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
