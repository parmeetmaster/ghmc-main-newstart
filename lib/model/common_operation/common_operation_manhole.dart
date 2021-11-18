/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"man_hole_tree_busstops","man_hole_name":"Hyderabad","type":"Man hole","address":"Hyderbad,khpb","zone":"Lb Nagar","circle":"Kapra","ward_name":"Kapra","area":"Hasthinapur","landmark":"Yallareddyguda-Yallareddyguda","col_id":"6195110e4ff9c04382286d9b"}

class CommonOperationManhole {
  CommonOperationManhole({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationManhole.fromJson(dynamic json) {
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

/// db_type : "man_hole_tree_busstops"
/// man_hole_name : "Hyderabad"
/// type : "Man hole"
/// address : "Hyderbad,khpb"
/// zone : "Lb Nagar"
/// circle : "Kapra"
/// ward_name : "Kapra"
/// area : "Hasthinapur"
/// landmark : "Yallareddyguda-Yallareddyguda"
/// col_id : "6195110e4ff9c04382286d9b"

class Data {
  Data({
      this.dbType, 
      this.manHoleName, 
      this.type, 
      this.address, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    manHoleName = json['man_hole_name'];
    type = json['type'];
    address = json['address'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? manHoleName;
  String? type;
  String? address;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['man_hole_name'] = manHoleName;
    map['type'] = type;
    map['address'] = address;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}