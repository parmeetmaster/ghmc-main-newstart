/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"residential_houses","house_type":"Kaccha","house_address":"hyderabad,khpb","owner_name":"Vivek","zone":"RAMANTHAPUR","circle":"Vanasthalipuram 1","ward_name":"RTC COLONY 1","area":"FCI COLONY","landmark":"kphp New-lb nagar","col_id":"61828743c777e9531d859a1a"}

class CommonOperationResident {
  CommonOperationResident({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationResident.fromJson(dynamic json) {
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

/// db_type : "residential_houses"
/// house_type : "Kaccha"
/// house_address : "hyderabad,khpb"
/// owner_name : "Vivek"
/// zone : "RAMANTHAPUR"
/// circle : "Vanasthalipuram 1"
/// ward_name : "RTC COLONY 1"
/// area : "FCI COLONY"
/// landmark : "kphp New-lb nagar"
/// col_id : "61828743c777e9531d859a1a"

class Data {
  Data({
      this.dbType, 
      this.houseType, 
      this.houseAddress, 
      this.ownerName, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    houseType = json['house_type'];
    houseAddress = json['house_address'];
    ownerName = json['owner_name'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? houseType;
  String? houseAddress;
  String? ownerName;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['house_type'] = houseType;
    map['house_address'] = houseAddress;
    map['owner_name'] = ownerName;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}