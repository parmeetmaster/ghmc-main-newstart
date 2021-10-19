// To parse this JSON data, do
//
//     final logHistory = logHistoryFromJson(jsonString);

import 'dart:convert';

LogHistory logHistoryFromJson(String str) =>
    LogHistory.fromJson(json.decode(str));

String logHistoryToJson(LogHistory data) => json.encode(data.toJson());

class LogHistory {
  LogHistory({
    this.success,
    this.login,
    this.message,
    this.data,
  });

  bool? success;
  bool? login;
  String? message;
  List<Datum>? data;

  factory LogHistory.fromJson(Map<String, dynamic> json) => LogHistory(
        success: json["success"],
        login: json["login"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "login": login,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.date,
    this.vechileType,
    this.vechileRegistrationNumber,
    this.sfaName,
    this.landmark,
    this.wardName,
    this.circle,
    this.zone,
  });

  DateTime? date;
  String? vechileType;
  String? vechileRegistrationNumber;
  String? sfaName;
  String? landmark;
  String? wardName;
  String? circle;
  String? zone;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: DateTime.parse(json["date"]),
        vechileType: json["vechile_type"],
        vechileRegistrationNumber: json["vechile_registration_number"],
        sfaName: json["sfa_name"],
        landmark: json["landmark"],
        wardName: json["ward_name"],
        circle: json["circle"],
        zone: json["zone"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "vechile_type": vechileType,
        "vechile_registration_number": vechileRegistrationNumber,
        "sfa_name": sfaName,
        "landmark": landmark,
        "ward_name": wardName,
        "circle": circle,
        "zone": zone,
      };
}
