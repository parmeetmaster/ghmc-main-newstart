/// success : true
/// message : "Successfully completed"
/// data : [{"id":"1","name":"Charminar"},{"id":"3","name":"Kukatpally"},{"id":"4","name":"Secunderabad"},{"id":"7","name":"Serilingampally"},{"id":"8","name":"Khairatabad"},{"id":"9","name":"L B Nagar"}]

class NewMenuItemModel {
  bool? success;
  String? message;
  List<NewMenuItem>? data;

  NewMenuItemModel({this.success, this.message, this.data});

  NewMenuItemModel.fromJson(dynamic json) {
    success = json["success"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(NewMenuItem.fromJson(v));
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
/// name : "Charminar"

class NewMenuItem {
  String? id;
  String? name;

  NewMenuItem({this.id, this.name});

  NewMenuItem.fromJson(dynamic json) {
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
