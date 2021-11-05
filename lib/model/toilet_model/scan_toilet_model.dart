/// success : true
/// login : true
/// message : "Successfully completed"
/// data : {"db_type":"toilets","address":"Hyderabad","temple_name":"Sulab complex","incharge_name":"Vivek","zone":"GHMC","circle":"Vanasthalipuram 1","ward_name":"RTC COLONY 1","area":"FCI COLONY","landmark":"kphp-lb nagar","col_id":"617797fefb713a19f9d5e5eb"}

class ScanToiletModel {
  ScanToiletModel({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  ScanToiletModel.fromJson(dynamic json) {
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

/// db_type : "toilets"
/// address : "Hyderabad"
/// temple_name : "Sulab complex"
/// incharge_name : "Vivek"
/// zone : "GHMC"
/// circle : "Vanasthalipuram 1"
/// ward_name : "RTC COLONY 1"
/// area : "FCI COLONY"
/// landmark : "kphp-lb nagar"
/// col_id : "617797fefb713a19f9d5e5eb"

class Data {
  Data({
      this.dbType, 
      this.address, 
      this.templeName, 
      this.inchargeName, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    address = json['address'];
    templeName = json['temple_name'];
    inchargeName = json['incharge_name'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? address;
  String? templeName;
  String? inchargeName;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['address'] = address;
    map['temple_name'] = templeName;
    map['incharge_name'] = inchargeName;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}