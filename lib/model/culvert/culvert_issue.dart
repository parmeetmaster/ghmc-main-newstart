/// success : true
/// login : true
/// data : {"culvert_id":"15","culvert_type":"major","culvert_name":"cluert","area":"moosapet","landmark":"Nagole","ward":"Nagole","circle":"Charminar","zone":"Charminar"}

class CulvertIssue {
  bool? success;
  bool? login;
  Data? data;

  CulvertIssue({this.success, this.login, this.data});

  CulvertIssue.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["login"] = login;
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }
}

/// culvert_id : "15"
/// culvert_type : "major"
/// culvert_name : "cluert"
/// area : "moosapet"
/// landmark : "Nagole"
/// ward : "Nagole"
/// circle : "Charminar"
/// zone : "Charminar"

class Data {
  String? culvertId;
  String? culvertType;
  String? culvertName;
  String? area;
  String? landmark;
  String? ward;
  String? circle;
  String? zone;

  Data(
      {this.culvertId,
      this.culvertType,
      this.culvertName,
      this.area,
      this.landmark,
      this.ward,
      this.circle,
      this.zone});

  Data.fromJson(dynamic json) {
    culvertId = json["culvert_id"];
    culvertType = json["culvert_type"];
    culvertName = json["culvert_name"];
    area = json["area"];
    landmark = json["landmark"];
    ward = json["ward"];
    circle = json["circle"];
    zone = json["zone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["culvert_id"] = culvertId;
    map["culvert_type"] = culvertType;
    map["culvert_name"] = culvertName;
    map["area"] = area;
    map["landmark"] = landmark;
    map["ward"] = ward;
    map["circle"] = circle;
    map["zone"] = zone;
    return map;
  }
}
