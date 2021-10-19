/// success : false
/// login : true
/// message : "Successfully completed"
/// data : [{"tag":"Total Summary","total":3862,"attend":0,"not_attend":3911,"ts_trips":0,"total_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total","attend_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=attend","not_attend_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=not_attend","ts_trips_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total_trips"},{"tag":"Swatch Summary","total":3510,"attend":0,"not_attend":3510,"ts_trips":0,"total_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total","attend_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=attend","not_attend_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=not_attend","ts_trips_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total_trips"},{"tag":"Non Swatch Summary","total":401,"attend":0,"not_attend":401,"ts_trips":0,"total_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalnotswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total","attend_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalnotswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=attend","not_attend_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalnotswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=not_attend","ts_trips_url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalnotswatchExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total_trips"}]

class DashboardVehicleModel {
  bool? success;
  bool? login;
  String? message;
  List<Data>? data;

  DashboardVehicleModel({this.success, this.login, this.message, this.data});

  DashboardVehicleModel.fromJson(dynamic json) {
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

/// tag : "Total Summary"
/// total : 3862
/// attend : 0
/// not_attend : 3911
/// ts_trips : 0
/// total_url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total"
/// attend_url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=attend"
/// not_attend_url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=not_attend"
/// ts_trips_url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/api/TotalExcel?user_id=\\\"1\\\"&date=1970-01-01&action=total_trips"

class Data {
  String? tag;
  int? total;
  int? attend;
  int? notAttend;
  int? tsTrips;
  String? totalUrl;
  String? attendUrl;
  String? notAttendUrl;
  String? tsTripsUrl;

  Data(
      {this.tag,
      this.total,
      this.attend,
      this.notAttend,
      this.tsTrips,
      this.totalUrl,
      this.attendUrl,
      this.notAttendUrl,
      this.tsTripsUrl});

  Data.fromJson(dynamic json) {
    tag = json["tag"];
    total = json["total"];
    attend = json["attend"];
    notAttend = json["not_attend"];
    tsTrips = json["ts_trips"];
    totalUrl = json["total_url"];
    attendUrl = json["attend_url"];
    notAttendUrl = json["not_attend_url"];
    tsTripsUrl = json["ts_trips_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["tag"] = tag;
    map["total"] = total;
    map["attend"] = attend;
    map["not_attend"] = notAttend;
    map["ts_trips"] = tsTrips;
    map["total_url"] = totalUrl;
    map["attend_url"] = attendUrl;
    map["not_attend_url"] = notAttendUrl;
    map["ts_trips_url"] = tsTripsUrl;
    return map;
  }
}
