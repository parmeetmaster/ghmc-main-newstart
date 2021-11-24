/// login : true
/// status : true
/// data : [{"_id":"619ceb2a23e09a07242dfc3f","name":"Blue Complex"}]

class ComplexName {
  ComplexName({
      this.login, 
      this.status, 
      this.data,});

  ComplexName.fromJson(dynamic json) {
    login = json['login'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? login;
  bool? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "619ceb2a23e09a07242dfc3f"
/// name : "Blue Complex"

class Data {
  Data({
      this.id, 
      this.name,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}