/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"db_type":"open_places","address":"Hyderbad,khpb","open_place_name":"Kphb","incharge_name":"Jashwanth","zone":"Lb Nagar","circle":"Kapra","ward_name":"Kapra","area":"Hasthinapur","landmark":"Hasthinapur-Hasthinapur","col_id":"61a0e136450f9320e258897e"}

class CommonOperationOpenPlaces {
  CommonOperationOpenPlaces({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationOpenPlaces.fromJson(dynamic json) {
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

/// db_type : "open_places"
/// address : "Hyderbad,khpb"
/// open_place_name : "Kphb"
/// incharge_name : "Jashwanth"
/// zone : "Lb Nagar"
/// circle : "Kapra"
/// ward_name : "Kapra"
/// area : "Hasthinapur"
/// landmark : "Hasthinapur-Hasthinapur"
/// col_id : "61a0e136450f9320e258897e"

class Data {
  var floor;

  Data({
      this.dbType, 
      this.address, 
      this.openPlaceName, 
      this.inchargeName, 
      this.zone,
    this.floor,
      this.circle, 
      this.wardName, 
      this.area, 
      this.landmark, 
      this.colId,});

  Data.fromJson(dynamic json) {
    dbType = json['db_type'];
    address = json['address'];
    floor = json['floor'];
    openPlaceName = json['open_place_name'];
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
  String? openPlaceName;
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
    map['open_place_name'] = openPlaceName;
    map['incharge_name'] = inchargeName;
    map['zone'] = zone;
    map['floor'] = floor;
    map['circle'] = circle;
    map['ward_name'] = wardName;
    map['area'] = area;
    map['landmark'] = landmark;
    map['col_id'] = colId;
    return map;
  }

}