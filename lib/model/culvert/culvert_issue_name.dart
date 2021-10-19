/// success : false
/// login : true
/// data : [{"id":"1","name":"Water","status":"Active"},{"id":"2","name":"leakage","status":"Active"}]
/// message : "Successfully completed"

class CulvertIssueName {
  bool? success;
  bool? login;
  List<CulvertIssueNameItem>? data;
  String? message;

  CulvertIssueName({this.success, this.login, this.data, this.message});

  CulvertIssueName.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(CulvertIssueNameItem.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["login"] = login;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }
}

/// id : "1"
/// name : "Water"
/// status : "Active"

class CulvertIssueNameItem {
  String? id;
  String? name;
  String? status;

  CulvertIssueNameItem({this.id, this.name, this.status});

  CulvertIssueNameItem.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["status"] = status;
    return map;
  }
}
