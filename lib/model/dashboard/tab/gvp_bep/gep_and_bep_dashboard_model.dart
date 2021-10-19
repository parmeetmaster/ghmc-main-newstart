/// success : true
/// login : true
/// message : "Successfully completed"
/// data : [{"name":"GVP","total":26,"attend":0,"note_attend":26,"trips":0,"url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/dashboard_gvp_bep_download?user_id=\\\"1\\\"&date=1970-01-01&type=GVP"},{"name":"BEP","total":99,"attend":0,"note_attend":99,"trips":0,"url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/dashboard_gvp_bep_download?user_id=\\\"1\\\"&date=1970-01-01&type=BEP"}]

class GepAndBepDashboardModel {
  bool? success;
  bool? login;
  String? message;
  List<Data>? data;

  GepAndBepDashboardModel({this.success, this.login, this.message, this.data});

  GepAndBepDashboardModel.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
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
    map["success"] = success;
    map["login"] = login;
    map["message"] = message;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "GVP"
/// total : 26
/// attend : 0
/// note_attend : 26
/// trips : 0
/// url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/api/dashboard_gvp_bep_download?user_id=\\\"1\\\"&date=1970-01-01&type=GVP"

class Data {
  String? name;
  int? total;
  int? attend;
  int? noteAttend;
  int? trips;
  String? url;

  Data(
      {this.name,
      this.total,
      this.attend,
      this.noteAttend,
      this.trips,
      this.url});

  Data.fromJson(dynamic json) {
    name = json["name"];
    total = json["total"];
    attend = json["attend"];
    noteAttend = json["note_attend"];
    trips = json["trips"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["total"] = total;
    map["attend"] = attend;
    map["note_attend"] = noteAttend;
    map["trips"] = trips;
    map["url"] = url;
    return map;
  }
}
