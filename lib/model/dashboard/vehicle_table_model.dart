// To parse this JSON data, do
//
//     final vehicleTableModel = vehicleTableModelFromJson(jsonString);

import 'dart:convert';

class VehicleTableModel {
  VehicleTableModel({
    this.success,
    this.login,
    this.message,
    this.data,
  });

  bool? success;
  bool? login;
  String? message;
  Data? data;

  factory VehicleTableModel.fromRawJson(String str) =>
      VehicleTableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleTableModel.fromJson(Map<String, dynamic> json) =>
      VehicleTableModel(
        success: json["success"],
        login: json["login"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "login": login,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.columns,
    this.rows,
  });

  List<String>? columns;
  List<List<String>>? rows;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        columns: List<String>.from(json["columns"].map((x) => x)),
        rows: List<List<String>>.from(
            json["rows"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "columns": List<dynamic>.from(columns!.map((x) => x)),
        "rows": List<dynamic>.from(
            rows!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
