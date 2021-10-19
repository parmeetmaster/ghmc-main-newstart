import 'dart:io';

/// success : true
/// login : true
/// data : [{"id":"16","date":"2021-07-03","issue_name":"Water","type":"green","image":"https://digitalraiz.com/projects/geo_tagginging_ghmc/uploads/culvertpics/fb2538e1f2ad2d7b333949faa1fe82f8.PNG","status":"pending","landmark":"dijcb","area":"Chanabatana","ward":"Ghansibazar","circle":"Charminar","zone":"Charminar"},{"id":"17","date":"2021-07-03","issue_name":"Water","type":"orange","image":"https://digitalraiz.com/projects/geo_tagginging_ghmc/uploads/culvertpics/2ff71b051a5fde1bdb1d099fed62f10f.jpg","status":"pending","landmark":"fsasda","area":"Biryanipoint","ward":"Pathergatti","circle":"Charminar","zone":"Charminar"},{"id":"18","date":"2021-07-03","issue_name":"Water","type":"orange","image":"https://digitalraiz.com/projects/geo_tagginging_ghmc/uploads/culvertpics/f066dcb85f507e8747e66ff7d7f94bd2.jpg","status":"pending","landmark":"fsasda","area":"Biryanipoint","ward":"Pathergatti","circle":"Charminar","zone":"Charminar"}]

class CulvertIssueZoneWiseModel {
  bool? success;
  bool? login;
  List<CulvertDataItem>? data;

  CulvertIssueZoneWiseModel({this.success, this.login, this.data});

  CulvertIssueZoneWiseModel.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(CulvertDataItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["login"] = login;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "16"
/// date : "2021-07-03"
/// issue_name : "Water"
/// type : "green"
/// image : "https://digitalraiz.com/projects/geo_tagginging_ghmc/uploads/culvertpics/fb2538e1f2ad2d7b333949faa1fe82f8.PNG"
/// status : "pending"
/// landmark : "dijcb"
/// area : "Chanabatana"
/// ward : "Ghansibazar"
/// circle : "Charminar"
/// zone : "Charminar"

class CulvertDataItem {
  String? id;
  String? date;
  String? issueName;
  String? type;
  String? image;
  String? status;
  String? landmark;
  String? area;
  String? ward;
  String? circle;
  String? zone;
  String? depth;
  String? issueDepth;
  String? culvertId;
  String? updatedStatus;
  File? statusImage;

  CulvertDataItem({
    this.id,
    this.date,
    this.issueName,
    this.type,
    this.image,
    this.status,
    this.landmark,
    this.area,
    this.ward,
    this.circle,
    this.zone,
    this.depth,
    this.issueDepth,
    this.culvertId,
  });

  CulvertDataItem.fromJson(dynamic json) {
    id = json["id"];
    date = json["date"];
    issueName = json["issue_name"];
    type = json["type"];
    image = json["image"];
    status = json["status"];
    landmark = json["landmark"];
    area = json["area"];
    ward = json["ward"];
    circle = json["circle"];
    zone = json["zone"];
    depth = json["depth"];
    issueDepth = json["issue_depth"];
    culvertId = json["culvert_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["date"] = date;
    map["issue_name"] = issueName;
    map["type"] = type;
    map["image"] = image;
    map["status"] = status;
    map["landmark"] = landmark;
    map["area"] = area;
    map["ward"] = ward;
    map["circle"] = circle;
    map["zone"] = zone;
    map["depth"] = depth;
    map["issue_depth"] = issueDepth;
    map["culvert_id"] = culvertId;
    return map;
  }
}
