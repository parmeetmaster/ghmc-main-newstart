/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"parkings","parking_name":"Kphb","owner_name":"Balu","address":"Hyderabad","zones_id":"610bab453052bb3dd85dd93f","circles_id":"60f89f42d03470d717e9f660","ward_id":"60f8a349d03470d717e9f661","landmark_id":"60fb352cf23336131060f2ca","area_id":"60fcc2db89282b30e00f1629","col_id":"6182868bc777e9531d859a07"}

class CommonOperationParking {
  CommonOperationParking({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationParking.fromJson(dynamic json) {
    success = json['success'];
    login = json['login'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  bool? login;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['login'] = login;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// db_type : "parkings"
/// parking_name : "Kphb"
/// owner_name : "Balu"
/// address : "Hyderabad"
/// zones_id : "610bab453052bb3dd85dd93f"
/// circles_id : "60f89f42d03470d717e9f660"
/// ward_id : "60f8a349d03470d717e9f661"
/// landmark_id : "60fb352cf23336131060f2ca"
/// area_id : "60fcc2db89282b30e00f1629"
/// col_id : "6182868bc777e9531d859a07"

class Data {
  Data({
      this.dbType, 
      this.parkingName, 
      this.ownerName, 
      this.address, 
      this.zonesId, 
      this.circlesId, 
      this.wardId, 
      this.landmarkId, 
      this.areaId, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    parkingName = json['parking_name'];
    ownerName = json['owner_name'];
    address = json['address'];
    zonesId = json['zones_id'];
    circlesId = json['circles_id'];
    wardId = json['ward_id'];
    landmarkId = json['landmark_id'];
    areaId = json['area_id'];
    colId = json['col_id'];
  }
  String? dbType;
  String? parkingName;
  String? ownerName;
  String? address;
  String? zonesId;
  String? circlesId;
  String? wardId;
  String? landmarkId;
  String? areaId;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['parking_name'] = parkingName;
    map['owner_name'] = ownerName;
    map['address'] = address;
    map['zones_id'] = zonesId;
    map['circles_id'] = circlesId;
    map['ward_id'] = wardId;
    map['landmark_id'] = landmarkId;
    map['area_id'] = areaId;
    map['col_id'] = colId;
    return map;
  }

}