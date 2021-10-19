// To parse this JSON data, do
//
//     final mapLocations = mapLocationsFromJson(jsonString);

import 'dart:convert';

MapLocations mapLocationsFromJson(String str) =>
    MapLocations.fromJson(json.decode(str));

String mapLocationsToJson(MapLocations data) => json.encode(data.toJson());

class MapLocations {
  MapLocations({
    this.success,
    this.login,
    this.data,
    this.message,
  });

  bool? success;
  bool? login;
  List<Datum>? data;
  String? message;

  factory MapLocations.fromJson(Map<String, dynamic> json) => MapLocations(
        success: json["success"],
        login: json["login"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "login": login,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.type,
    this.area,
    this.landmark,
    this.latitude,
    this.longitude,
    this.trips,
    this.color,
    this.image,
  });

  String? id;
  String? type;
  String? area;
  String? landmark;
  String? latitude;
  String? longitude;
  String? trips;
  String? color;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        area: json["area"],
        landmark: json["landmark"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        trips: json["trips"],
        color: json["color"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "area": area,
        "landmark": landmark,
        "latitude": latitude,
        "longitude": longitude,
        "trips": trips,
        "color": color,
        "image": image,
      };
}
