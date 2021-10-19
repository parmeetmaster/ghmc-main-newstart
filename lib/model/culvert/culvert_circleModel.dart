// To parse this JSON data, do
//
//     final circle = circleFromJson(jsonString);

import 'dart:convert';

Circle circleFromJson(String str) => Circle.fromJson(json.decode(str));

String circleToJson(Circle data) => json.encode(data.toJson());

class Circle {
  Circle({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory Circle.fromJson(Map<String, dynamic> json) => Circle(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
