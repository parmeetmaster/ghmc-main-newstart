// To parse this JSON data, do
//
//     final absentVehicles = absentVehiclesFromJson(jsonString);

import 'dart:convert';

AbsentVehicleModel absentVehiclesFromJson(String str) =>
    AbsentVehicleModel.fromJson(json.decode(str));

String absentVehiclesToJson(AbsentVehicleModel data) => json.encode(data.toJson());

class AbsentVehicleModel {
  AbsentVehicleModel({
    this.success,
    this.login,
    this.message,
    this.data,
  });

  bool? success;
  bool? login;
  String? message;
  List<Datum>? data;

  factory AbsentVehicleModel.fromJson(Map<String, dynamic> json) => AbsentVehicleModel(
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
    this.id,
    this.vechileType,
    this.vechileRegistrationNumber,
    this.sfaName,
    this.sfaMobileNumber,
    this.landmark,
    this.wardName,
    this.circle,
    this.zone,
    this.commentUpdate,
  });

  String? id;
  String? vechileType;
  String? vechileRegistrationNumber;
  String? sfaName;
  String? sfaMobileNumber;
  String? landmark;
  String? wardName;
  String? circle;
  String? zone;
  String? commentUpdate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        vechileType: json["vechile_type"],
        vechileRegistrationNumber: json["vechile_registration_number"],
        sfaName: json["sfa_name"],
        sfaMobileNumber: json["sfa_mobile_number"],
        landmark: json["landmark"],
        wardName: json["ward_name"],
        circle: json["circle"],
        zone: json["zone"],
        commentUpdate: json["comment_update"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vechile_type": vechileType,
        "vechile_registration_number": vechileRegistrationNumber,
        "sfa_name": sfaName,
        "sfa_mobile_number": sfaMobileNumber,
        "landmark": landmark,
        "ward_name": wardName,
        "circle": circle,
        "zone": zone,
        "comment_update": commentUpdate,
      };
}
