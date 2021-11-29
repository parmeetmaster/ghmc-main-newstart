/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"comercial_flats","business_name":"","category":"Residencial","name":"Stone colony","zone":"Lb Nagar","circle":"Kapra","ward_name":"Kapra","area":"Gandhi Nagar","landmark":"Gandhi Nagar-Gandhi Nagar","col_id":"619e3610335e7e33b9ed8031"}

class CommonFlatOperationsModel {
  CommonFlatOperationsModel({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonFlatOperationsModel.fromJson(dynamic json) {
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

/// db_type : "comercial_flats"
/// business_name : ""
/// category : "Residencial"
/// name : "Stone colony"
/// zone : "Lb Nagar"
/// circle : "Kapra"
/// ward_name : "Kapra"
/// area : "Gandhi Nagar"
/// landmark : "Gandhi Nagar-Gandhi Nagar"
/// col_id : "619e3610335e7e33b9ed8031"

class Data {
  Data({
      this.dbType, 
      this.businessName, 
      this.category, 
      this.name, 
      this.zone, 
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    businessName = json['business_name'];
    category = json['category'];
    name = json['name'];
    zone = json['zone'];
    circle = json['circle'];
    wardName = json['ward_name'];
    area = json['area'];
    landmark = json['landmark'];
    colId = json['col_id'];
  }
  String? dbType;
  String? businessName;
  String? category;
  String? name;
  String? zone;
  String? circle;
  String? wardName;
  String? area;
  String? landmark;
  String? colId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['db_type'] = dbType;
    map['business_name'] = businessName;
    map['category'] = category;
    map['name'] = name;
    map['zone'] = zone;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}