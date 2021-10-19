// To parse this JSON data, do
//
//     final transportStationModel = transportStationModelFromJson(jsonString);

import 'dart:convert';

class TransferStationModel {
  TransferStationModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<TransferTypeDataItem>? data;

  factory TransferStationModel.fromRawJson(String str) =>
      TransferStationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransferStationModel.fromJson(Map<String, dynamic> json) =>
      TransferStationModel(
        success: json["success"],
        message: json["message"],
        data: List<TransferTypeDataItem>.from(
            json["data"].map((x) => TransferTypeDataItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TransferTypeDataItem {
  TransferTypeDataItem({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory TransferTypeDataItem.fromRawJson(String str) =>
      TransferTypeDataItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransferTypeDataItem.fromJson(Map<String, dynamic> json) =>
      TransferTypeDataItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
