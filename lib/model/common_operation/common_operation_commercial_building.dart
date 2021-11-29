/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"comercial_buildings","name":"Blue Complex","address":"Vanasthalipuram","floors":"8","zone":"Lb Nagar","circle":"Kapra","ward_name":"Kapra","area":"Hasthinapur","landmark":"Hasthinapur-Hasthinapur","col_id":"61a0dedc450f9320e2588809"}

class CommonOperationCommercialBuilding {
  CommonOperationCommercialBuilding({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationCommercialBuilding.fromJson(dynamic json) {
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

/// db_type : "comercial_buildings"
/// name : "Blue Complex"
/// address : "Vanasthalipuram"
/// floors : "8"
/// zone : "Lb Nagar"
/// circle : "Kapra"
/// ward_name : "Kapra"
/// area : "Hasthinapur"
/// landmark : "Hasthinapur-Hasthinapur"
/// col_id : "61a0dedc450f9320e2588809"

class Data {
  Data({
      this.dbType, 
      this.name, 
      this.address, 
      this.floors, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    name = json['name'];
    address = json['address'];
    floors = json['floors'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? name;
  String? address;
  String? floors;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['name'] = name;
    map['address'] = address;
    map['floors'] = floors;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}