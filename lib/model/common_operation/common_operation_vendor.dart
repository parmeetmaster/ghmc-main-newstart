/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"streetvendors","owner_name":"Jashwanth kumar","business_type":"Shop","business_name":"Stationary","zone":"RAMANTHAPUR","circle":"Vanasthalipuram 1","ward_name":"RTC COLONY 1","area":"FCI COLONY","landmark":"kphp New-lb nagar","col_id":"6182859cc777e9531d8599f5"}

class CommonOperationVendor {
  CommonOperationVendor({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationVendor.fromJson(dynamic json) {
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

/// db_type : "streetvendors"
/// owner_name : "Jashwanth kumar"
/// business_type : "Shop"
/// business_name : "Stationary"
/// zone : "RAMANTHAPUR"
/// circle : "Vanasthalipuram 1"
/// ward_name : "RTC COLONY 1"
/// area : "FCI COLONY"
/// landmark : "kphp New-lb nagar"
/// col_id : "6182859cc777e9531d8599f5"

class Data {
  Data({
      this.dbType, 
      this.ownerName, 
      this.businessType, 
      this.businessName, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    ownerName = json['owner_name'];
    businessType = json['business_type'];
    businessName = json['business_name'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? ownerName;
  String? businessType;
  String? businessName;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['owner_name'] = ownerName;
    map['business_type'] = businessType;
    map['business_name'] = businessName;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}