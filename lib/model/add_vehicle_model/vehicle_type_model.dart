// To parse this JSON data, do
//
//     final vehicleTypeModel = vehicleTypeModelFromJson(jsonString);

import 'dart:convert';

class VehicleTypeModel {
  VehicleTypeModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<VehicleTypeDataItem>? data;

  factory VehicleTypeModel.fromRawJson(String str) =>
      VehicleTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) =>
      VehicleTypeModel(
        success: json["success"],
        message: json["message"],
        data: List<VehicleTypeDataItem>.from(
            json["data"].map((x) => VehicleTypeDataItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VehicleTypeDataItem {
  VehicleTypeDataItem({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory VehicleTypeDataItem.fromRawJson(String str) =>
      VehicleTypeDataItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleTypeDataItem.fromJson(Map<String, dynamic> json) =>
      VehicleTypeDataItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
