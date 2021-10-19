/// success : true
/// login : true
/// message : "Successfully completed"
/// data : [{"home":true,"data_entry":true,"geo_tagging":true,"add_culvert":true,"issue_culvert":false,"add_gvp/bep":false,"log_history":false,"absent_vehicles":false,"complaints":false,"dashboard":false}]

class DrawerAuthority {
  bool? success;
  bool? login;
  String? message;
  List<Data>? data;

  DrawerAuthority({
      this.success, 
      this.login, 
      this.message, 
      this.data});

  DrawerAuthority.fromJson(dynamic json) {
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

/// home : true
/// data_entry : true
/// geo_tagging : true
/// add_culvert : true
/// issue_culvert : false
/// add_gvp/bep : false
/// log_history : false
/// absent_vehicles : false
/// complaints : false
/// dashboard : false

class Data {
  bool? home;
  bool? dataEntry;
  bool? geoTagging;
  bool? addCulvert;
  bool? issueCulvert;
  bool? addGvpbep;
  bool? logHistory;
  bool? absentVehicles;
  bool? complaints;
  bool? dashboard;

  Data({
      this.home, 
      this.dataEntry, 
      this.geoTagging, 
      this.addCulvert, 
      this.issueCulvert, 
      this.addGvpbep,
      this.logHistory, 
      this.absentVehicles, 
      this.complaints, 
      this.dashboard});

  Data.fromJson(dynamic json) {
    home = json["home"];
    dataEntry = json["data_entry"];
    geoTagging = json["geo_tagging"];
    addCulvert = json["add_culvert"];
    issueCulvert = json["issue_culvert"];
    addGvpbep = json["add_gvp/bep"];
    logHistory = json["log_history"];
    absentVehicles = json["absent_vehicles"];
    complaints = json["complaints"];
    dashboard = json["dashboard"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["home"] = home;
    map["data_entry"] = dataEntry;
    map["geo_tagging"] = geoTagging;
    map["add_culvert"] = addCulvert;
    map["issue_culvert"] = issueCulvert;
    map["add_gvp/bep"] = addGvpbep;
    map["log_history"] = logHistory;
    map["absent_vehicles"] = absentVehicles;
    map["complaints"] = complaints;
    map["dashboard"] = dashboard;
    return map;
  }

}