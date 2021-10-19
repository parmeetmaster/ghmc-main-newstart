// To parse this JSON data, do
//
//     final ownerTypeModel = ownerTypeModelFromJson(jsonString);

import 'dart:convert';

class OwnerTypeModel {
  OwnerTypeModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<OwnerTypeDataItem>? data;

  factory OwnerTypeModel.fromRawJson(String str) =>
      OwnerTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OwnerTypeModel.fromJson(Map<String, dynamic> json) => OwnerTypeModel(
        success: json["success"],
        message: json["message"],
        data: List<OwnerTypeDataItem>.from(
            json["data"].map((x) => OwnerTypeDataItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OwnerTypeDataItem {
  OwnerTypeDataItem({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory OwnerTypeDataItem.fromRawJson(String str) =>
      OwnerTypeDataItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OwnerTypeDataItem.fromJson(Map<String, dynamic> json) =>
      OwnerTypeDataItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
