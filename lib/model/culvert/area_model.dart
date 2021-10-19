/// success : true
/// message : "Successfully completed"
/// data : [{"id":"1","name":"Akberalishahdargaroad"},{"id":"2","name":"Alijahkotlaroad"},{"id":"5","name":"Balajitempleroad"},{"id":"7","name":"BelaCrossroad"},{"id":"8","name":"Biryanipoint"},{"id":"10","name":"Chapalgalli"},{"id":"12","name":"Chettabazarroad"},{"id":"14","name":"CityCivilcourt"},{"id":"15","name":"Darulshifaroad"},{"id":"16","name":"Deevandevdi"},{"id":"22","name":"GovtBoyshighschoolroad"},{"id":"23","name":"Gowlipuraroad"},{"id":"24","name":"Gurnagalli"},{"id":"27","name":"Haribowliroad"},{"id":"29","name":"Ishrathmahal"},{"id":"30","name":"Jamalmarketroad"},{"id":"31","name":"Kalikamanroad"},{"id":"35","name":"Kotlaalijahroad"},{"id":"36","name":"Mairalammnadimarket"},{"id":"37","name":"Mairalammnadimarketkaman"},{"id":"38","name":"Mangathrai"},{"id":"39","name":"Masjidroad"},{"id":"40","name":"Miralammandi\ncenterpoint"},{"id":"41","name":"Miralammandiroad"},{"id":"42","name":"Miralammnaditemple"},{"id":"44","name":"Mogalpurachamanroad"},{"id":"45","name":"MogalpuraFirestation"},{"id":"46","name":"Mogalpuraroad"},{"id":"47","name":"Mogalpurawatertankroad"},{"id":"51","name":"NearBalagunjroad"},{"id":"52","name":"NearBelaXroad"},{"id":"55","name":"NearIshrathmahal"},{"id":"58","name":"NearMithrasportsclub"},{"id":"60","name":"Panjeshahroad"},{"id":"65","name":"Rangelikidki"},{"id":"67","name":"Salargunjmeasiumroad"},{"id":"68","name":"Sardarmahalroad"},{"id":"69","name":"SardarPatelroad"},{"id":"74","name":"Shivalayamtempleroad"},{"id":"75","name":"Shivatempleroad"},{"id":"76","name":"Sudhatheaterroad"},{"id":"77","name":"Sulthanshahi"},{"id":"78","name":"Sulthanshahichamanroad"},{"id":"79","name":"Sulthanshahiplayground"},{"id":"80","name":"Sulthanshahiroad"},{"id":"81","name":"Talabkattaroad"}]

class CulvertDataModel {
  bool? success;
  String? message;
  List<DataItem>? data = [];

  CulvertDataModel({this.success, this.message, this.data});

  CulvertDataModel.fromJson(dynamic json) {
    success = json["success"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(DataItem.fromJson(v));
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
/// name : "Akberalishahdargaroad"

class DataItem {
  String? id;
  String? name;

  DataItem({this.id, this.name});

  DataItem.fromJson(dynamic json) {
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
