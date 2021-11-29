/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"communityhalls","business_type":"Business","business_name":"Hall","shop_address":"Hyderabad","zone":"Lb Nagar","circle":"Kapra","ward_name":"Kapra","area":"Hasthinapur","landmark":"Yallareddyguda-Yallareddyguda","col_id":"61950e2be7597942176cffe1"}

class CommonOperationCommunityHall {
  CommonOperationCommunityHall({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationCommunityHall.fromJson(dynamic json) {
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

/// db_type : "communityhalls"
/// business_type : "Business"
/// business_name : "Hall"
/// shop_address : "Hyderabad"
/// zone : "Lb Nagar"
/// circle : "Kapra"
/// ward_name : "Kapra"
/// area : "Hasthinapur"
/// landmark : "Yallareddyguda-Yallareddyguda"
/// col_id : "61950e2be7597942176cffe1"

class Data {
  Data({
      this.dbType, 
      this.businessType, 
      this.businessName, 
      this.shopAddress, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    businessType = json['business_type'];
    businessName = json['business_name'];
    shopAddress = json['shop_address'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? businessType;
  String? businessName;
  String? shopAddress;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['business_type'] = businessType;
    map['business_name'] = businessName;
    map['shop_address'] = shopAddress;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}