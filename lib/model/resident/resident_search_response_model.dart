/// status : true
/// data : [{"uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","house_address":"hyderabad,khpb","owner_name":"Vivek","owner_mobile":"9032774452","total_members":2}]
/// message : "success"

class ResidentSearchResponseModel {
  ResidentSearchResponseModel({
      this.status, 
      this.data, 
      this.message,});

  ResidentSearchResponseModel.fromJson(dynamic json) {
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

/// uuid : "oF_ZkDQJs6f_YONiZ7VvZHGtU"
/// house_address : "hyderabad,khpb"
/// owner_name : "Vivek"
/// owner_mobile : "9032774452"
/// total_members : 2

class Data {
  Data({
      this.uuid, 
      this.houseAddress, 
      this.ownerName, 
      this.ownerMobile, 
      this.totalMembers,});

  Data.fromJson(dynamic json) {
    uuid = json['uuid'];
    houseAddress = json['house_address'];
    ownerName = json['owner_name'];
    ownerMobile = json['owner_mobile'];
    totalMembers = json['total_members'];
  }
  String? uuid;
  String? houseAddress;
  String? ownerName;
  String? ownerMobile;
  int? totalMembers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = uuid;
    map['house_address'] = houseAddress;
    map['owner_name'] = ownerName;
    map['owner_mobile'] = ownerMobile;
    map['total_members'] = totalMembers;
    return map;
  }

}