// To parse this JSON data, do
//
//     final driverDataModel = driverDataModelFromJson(jsonString);

import 'dart:convert';

class QrDataModel {
  QrDataModel({
    this.success,
    this.login,
    this.message,
    this.data,
  });

  bool? success;
  bool? login;
  String? message;
  QrData? data;

  factory QrDataModel.fromRawJson(String str) =>
      QrDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrDataModel.fromJson(Map<String, dynamic> json) => QrDataModel(
        success: json["success"],
        login: json["login"],
        message: json["message"],
        data: QrData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "login": login,
        "message": message,
        "data": data!.toJson(),
      };
}

class QrData {
  QrData({
    this.vechileType,
    this.vechileNo,
    this.driverName,
    this.driverNo,
    this.address,
    this.landmark,
    this.ward,
    this.circle,
    this.zone,
    this.owner_type,
    this.createdDate,
    this.id,
    this.geoId,
    this.scanType,
    this.culvertId,
    this.culvertType,
    this.culvertName,
    this.area,
    this.distance,
    this.depth,
  });

  String? vechileType;
  String? vechileNo;
  String? driverName;
  String? driverNo;
  String? address;
  String? landmark;
  String? ward;
  String? circle;
  String? zone;
  String? createdDate;
  String? owner_type;
  String? id;
  String? geoId;
  String? scanType;
  String? culvertId;
  String? culvertType;
  String? culvertName;
  String? area;
  String? distance;
  String? depth;

  factory QrData.fromRawJson(String str) => QrData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrData.fromJson(Map<String, dynamic> json) => QrData(
        id: json["id"],
        vechileType: json["vechile_type"],
        vechileNo: json["vechile_no"],
        driverName: json["driver_name"],
        driverNo: json["driver_no"],
        address: json["address"],
        landmark: json["landmark"],
        ward: json["ward"],
        circle: json["circle"],
        zone: json["zone"],
        owner_type: json["owner_type"],
        createdDate: json["created_date"],
        geoId: json["geo_id"],
        scanType: json["scan_type"],
        culvertId: json["culvert_id"],
        culvertType: json["culvert_type"],
        culvertName: json["culvert_name"],
        area: json["area"],
        distance: json["distance"],
        depth: json["depth"],
      );

  Map<String, dynamic> toJson() => {
        "vechile_type": vechileType,
        "vechile_no": vechileNo,
        "driver_name": driverName,
        "driver_no": driverNo,
        "address": address,
        "landmark": landmark,
        "ward": ward,
        "circle": circle,
        "zone": zone,
        "owner_type": owner_type,
        "created_date": createdDate,
        "geo_id": geoId,
        "scan_type": scanType,
        "culvert_id": culvertId,
        "culvert_type": culvertType,
        "culvert_name": culvertName,
        "area": area,
        "distance": distance,
        "depth": depth,
      };
}
