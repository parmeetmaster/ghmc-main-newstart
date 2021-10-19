// To parse this JSON data, do
//
//     final credentialsModel = credentialsModelFromJson(jsonString);

import 'dart:convert';

class CredentialsModel {
  CredentialsModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CredentialsModel.fromRawJson(String str) =>
      CredentialsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CredentialsModel.fromJson(Map<String, dynamic> json) =>
      CredentialsModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.departmentId,
    this.departmentName,
    this.token,
    this.access,
  });

  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? departmentId;
  String? departmentName;
  String? token;
  List<Access>? access;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        token: json["token"],
        access:
            List<Access>.from(json["access"].map((x) => Access.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "department_id": departmentId,
        "department_name": departmentName,
        "token": token,
        "access": List<dynamic>.from(access!.map((x) => x.toJson())),
      };
}

class Access {
  Access({
    this.zone,
    this.zoneId,
    this.circle,
    this.circleId,
    this.ward,
    this.wardId,
    this.landmarks,
    this.landmarksId,
    this.geoTagButtons,
  });

  String? zone;
  String? zoneId;
  String? circle;
  String? circleId;
  String? ward;
  String? wardId;
  String? landmarks;
  String? landmarksId;
  List<GeoTagButton>? geoTagButtons;

  factory Access.fromRawJson(String str) => Access.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        zone: json["zone"],
        zoneId: json["zone_id"],
        circle: json["circle"],
        circleId: json["circle_id"],
        ward: json["ward"],
        wardId: json["ward_id"],
        landmarks: json["landmarks"],
        landmarksId: json["landmarks_id"],
        geoTagButtons: List<GeoTagButton>.from(
            json["geo_tag_buttons"].map((x) => GeoTagButton.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zone": zone,
        "zone_id": zoneId,
        "circle": circle,
        "circle_id": circleId,
        "ward": ward,
        "ward_id": wardId,
        "landmarks": landmarks,
        "landmarks_id": landmarksId,
        "geo_tag_buttons":
            List<dynamic>.from(geoTagButtons!.map((x) => x.toJson())),
      };
}

class GeoTagButton {
  GeoTagButton({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory GeoTagButton.fromRawJson(String str) =>
      GeoTagButton.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeoTagButton.fromJson(Map<String, dynamic> json) => GeoTagButton(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class LoginError {
  LoginError({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<dynamic>? data;

  factory LoginError.fromRawJson(String str) =>
      LoginError.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
        success: json["success"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x)),
      };
}
