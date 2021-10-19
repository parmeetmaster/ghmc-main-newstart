/// success : true
/// message : "Successfully completed"
/// data : [{"id":"1","name":"vehcile"},{"id":"2","name":"Qrcodes"}]

class SupportTypes {
  bool? success;
  String? message;
  List<SupportItems>? data;

  SupportTypes({this.success, this.message, this.data});

  SupportTypes.fromJson(dynamic json) {
    success = json["success"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(SupportItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["message"] = message;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// name : "vehcile"

class SupportItems {
  String? id;
  String? name;

  SupportItems({this.id, this.name});

  SupportItems.fromJson(dynamic json) {
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
