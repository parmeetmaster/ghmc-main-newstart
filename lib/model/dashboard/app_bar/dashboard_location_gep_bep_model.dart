/// success : true
/// login : true
/// message : "Successfully completed"
/// found : true
/// data : {"id":"1","type":"BEP","area":"Kalikamanroad","landmark":"Panjeshah point","circle":"Charminar","zone":"Charminar","distance":"7.491647714848199"}

class DashboardLocationGepBepModel {
  bool? success;
  bool? login;
  String? message;
  bool? found;
  Data? data;

  DashboardLocationGepBepModel(
      {this.success, this.login, this.message, this.found, this.data});

  DashboardLocationGepBepModel.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
    message = json["message"];
    found = json["found"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["login"] = login;
    map["message"] = message;
    map["found"] = found;
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }
}

/// id : "1"
/// type : "BEP"
/// area : "Kalikamanroad"
/// landmark : "Panjeshah point"
/// circle : "Charminar"
/// zone : "Charminar"
/// distance : "7.491647714848199"

class Data {
  String? id;
  String? type;
  String? area;
  String? ward;
  String? landmark;
  String? circle;
  String? zone;
  String? distance;

  Data(
      {this.id,
      this.type,
      this.area,
      this.landmark,
      this.circle,
      this.zone,
      this.distance});

  Data.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    area = json["area"];
    landmark = json["landmark"];
    circle = json["circle"];
    zone = json["zone"];
    ward = json["ward_name"];
    distance = json["distance"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["area"] = area;
    map["landmark"] = landmark;
    map["ward_name"] = ward;
    map["circle"] = circle;
    map["zone"] = zone;
    map["distance"] = distance;
    return map;
  }
}
