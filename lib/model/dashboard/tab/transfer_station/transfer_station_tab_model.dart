/// success : false
/// login : true
/// message : "Successfully completed"
/// total_vehicles : 4040
/// trips : "876"
/// garbage_collection : "69500"
/// data : [{"ts_name":"TSM-Jiyaguda","vehicles_count":160,"trips_count":"235","garbage_collection":"16825","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4915"},{"ts_name":"TSM-HIMSW-01","vehicles_count":0,"trips_count":"14","garbage_collection":"1400","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4916"},{"ts_name":"TSM-SAKET","vehicles_count":66,"trips_count":"36","garbage_collection":"2400","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4919"},{"ts_name":"TSM-DEVENDER-NAGAR-02","vehicles_count":41,"trips_count":"32","garbage_collection":"3175","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4920"},{"ts_name":"TSM-NAGOLE","vehicles_count":249,"trips_count":"144","garbage_collection":"10800","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4921"},{"ts_name":"TSM-KATEDAN","vehicles_count":142,"trips_count":"1","garbage_collection":"50","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4923"},{"ts_name":"TSM-YOUSUFGUDA","vehicles_count":302,"trips_count":"212","garbage_collection":"18600","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4924"},{"ts_name":"TSM-HMTPIPELINE","vehicles_count":262,"trips_count":"116","garbage_collection":"8450","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4928"},{"ts_name":"TSM-SANJEEVAIAH-PARK","vehicles_count":45,"trips_count":"6","garbage_collection":"200","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4931"},{"ts_name":"TSM-BANDLAGUDA","vehicles_count":0,"trips_count":"40","garbage_collection":"4000","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4936"},{"ts_name":"TSM-FATEHANAGAR","vehicles_count":52,"trips_count":"8","garbage_collection":"575","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4941"},{"ts_name":"TSM-HASMATHAPET LAKE","vehicles_count":42,"trips_count":"28","garbage_collection":"2675","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4942"},{"ts_name":"TSM-KHAJAGUDA","vehicles_count":37,"trips_count":"4","garbage_collection":"350","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4946"}]

class TransferStationTabModel {
  bool? success;
  bool? login;
  String? message;
  int? totalVehicles;
  String? trips;
  String? garbageCollection;
  List<TransferStationDataItem>? data;

  TransferStationTabModel(
      {this.success,
      this.login,
      this.message,
      this.totalVehicles,
      this.trips,
      this.garbageCollection,
      this.data});

  TransferStationTabModel.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
    message = json["message"];
    totalVehicles = json["total_vehicles"];
    trips = json["trips"];
    garbageCollection = json["garbage_collection"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(TransferStationDataItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["login"] = login;
    map["message"] = message;
    map["total_vehicles"] = totalVehicles;
    map["trips"] = trips;
    map["garbage_collection"] = garbageCollection;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ts_name : "TSM-Jiyaguda"
/// vehicles_count : 160
/// trips_count : "235"
/// garbage_collection : "16825"
/// url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/transfer_station_download/4915"

class TransferStationDataItem {
  String? tsName;
  int? vehiclesCount;
  String? tripsCount;
  String? garbageCollection;
  String? url;

  TransferStationDataItem(
      {this.tsName,
      this.vehiclesCount,
      this.tripsCount,
      this.garbageCollection,
      this.url});

  TransferStationDataItem.fromJson(dynamic json) {
    tsName = json["ts_name"];
    vehiclesCount = json["vehicles_count"];
    tripsCount = json["trips_count"];
    garbageCollection = json["garbage_collection"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ts_name"] = tsName;
    map["vehicles_count"] = vehiclesCount;
    map["trips_count"] = tripsCount;
    map["garbage_collection"] = garbageCollection;
    map["url"] = url;
    return map;
  }
}
