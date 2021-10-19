/// success : true
/// login : true
/// data : [{"id":"1","name":"Charminar","green":"1","orange":"2","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/1"},{"id":"2","name":"Santhosh Nagar","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/2"},{"id":"3","name":"Saroornagar","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/3"},{"id":"4","name":"Falaknama","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/4"},{"id":"5","name":"Chandrayangutta","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/5"},{"id":"6","name":"Malakpet","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/6"},{"id":"8","name":"Secunderabad","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/8"},{"id":"10","name":"Hayathnagar","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/10"},{"id":"12","name":"Musheerabad","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/12"},{"id":"13","name":"LB Nagar","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/13"},{"id":"14","name":"AMBERPET","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/14"},{"id":"16","name":"Rajendranagar","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/16"},{"id":"17","name":"Yousufguda","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/17"},{"id":"18","name":"Uppal","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/18"},{"id":"19","name":"Malkajigiri","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/19"},{"id":"20","name":"Begumpet","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/20"},{"id":"21","name":"Gosha Mahal","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/21"},{"id":"22","name":"Khairatabad","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/22"},{"id":"23","name":"Mehdipatnam","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/23"},{"id":"24","name":"jubilee hills","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/24"},{"id":"25","name":"Ramchandrapuram & Patancheruvu","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/25"},{"id":"104","name":"Kapra","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/104"},{"id":"105","name":"Karwan","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/105"},{"id":"182","name":"Quthubullapur","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/182"},{"id":"259","name":"Serilingampally","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/259"},{"id":"260","name":"Chandanagar","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/260"},{"id":"261","name":"Moosapet","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/261"},{"id":"262","name":"Kukatpally","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/262"},{"id":"263","name":"Gajularamaram","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/263"},{"id":"264","name":"Alwal","green":"0","orange":"0","red":"0","url":"https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/264"}]

class CulvertDashBoardModel {
  bool? success;
  bool? login;
  List<CulvertItem>? data;

  CulvertDashBoardModel({
      this.success, 
      this.login, 
      this.data});

  CulvertDashBoardModel.fromJson(dynamic json) {
    success = json["success"];
    login = json["login"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(CulvertItem.fromJson(v));
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

/// id : "1"
/// name : "Charminar"
/// green : "1"
/// orange : "2"
/// red : "0"
/// url : "https://digitalraiz.com/projects/geo_tagginging_ghmc/culvertissue_download_get/1"

class CulvertItem {
  String? id;
  String? name;
  String? green;
  String? orange;
  String? red;
  String? url;

  CulvertItem({
      this.id, 
      this.name, 
      this.green, 
      this.orange, 
      this.red, 
      this.url});

  CulvertItem.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    green = json["green"];
    orange = json["orange"];
    red = json["red"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["green"] = green;
    map["orange"] = orange;
    map["red"] = red;
    map["url"] = url;
    return map;
  }

}