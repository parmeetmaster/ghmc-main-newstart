/// status : true
/// data : [{"_id":"6196574a3d13fd7fab3f644f","owner_name":"Prakash","zone_name":"Lb Nagar","circle_name":"Kapra","wardname":"Kapra","area_name":"Hasthinapur","landmark_name":"Hasthinapur - Hasthinapur"},{"_id":"61966c2e05891205f5c5d290","owner_name":"jj","zone_name":"Lb Nagar","circle_name":"Uppal","wardname":"Chilka Nagar","area_name":"High Court Colony","landmark_name":"High Court Colony - High Court Colony"},{"_id":"61966f4305891205f5c5d2d9","owner_name":"j","zone_name":"Lb Nagar","circle_name":"Uppal","wardname":"Chilka Nagar","area_name":"Ajmath Nagar","landmark_name":"Ajmath Nagar - Ajmath Nagar"}]
/// message : "success"

class ResidentPreSubmitDetialModel {
  ResidentPreSubmitDetialModel({
      this.status, 
      this.data, 
      this.message,});

  ResidentPreSubmitDetialModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<Data>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

/// _id : "6196574a3d13fd7fab3f644f"
/// owner_name : "Prakash"
/// zone_name : "Lb Nagar"
/// circle_name : "Kapra"
/// wardname : "Kapra"
/// area_name : "Hasthinapur"
/// landmark_name : "Hasthinapur - Hasthinapur"

class Data {
  Data({
      this.id, 
      this.ownerName, 
      this.zoneName, 
      this.circleName, 
      this.wardname, 
      this.areaName, 
      this.landmarkName,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    ownerName = json['owner_name'];
    zoneName = json['zone_name'];
    circleName = json['circle_name'];
    wardname = json['wardname'];
    areaName = json['area_name'];
    landmarkName = json['landmark_name'];
  }
  String? id;
  String? ownerName;
  String? zoneName;
  String? circleName;
  String? wardname;
  String? areaName;
  String? landmarkName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['owner_name'] = ownerName;
    map['zone_name'] = zoneName;
    map['circle_name'] = circleName;
    map['wardname'] = wardname;
    map['area_name'] = areaName;
    map['landmark_name'] = landmarkName;
    return map;
  }

}