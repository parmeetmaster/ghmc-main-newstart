/// login : true
/// success : true
/// message : "Successfully completed"
/// data : [{"id":"all","name":"all"},{"id":"0","name":"Sat Vehicles"},{"id":"1","name":"Transport Vehicles"}]

class VehicleType {
  bool? login;
  bool? success;
  String? message;
  List<Data>? data;

  VehicleType({this.login, this.success, this.message, this.data});

  VehicleType.fromJson(dynamic json) {
    login = json["login"];
    success = json["success"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["login"] = login;
    map["success"] = success;
    map["message"] = message;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "all"
/// name : "all"

class Data {
  String? id;
  String? name;

  Data({this.id, this.name});

  Data.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}
