/// login : true
/// status : true
/// data : {"business_type":[{"name":"Kirana shop"},{"name":"Medical shop"},{"name":"Education"},{"name":"Auto mobiles"}],"category_type":[{"name":"Business"},{"name":"Residencial"}],"licence":[{"licence":"Perminent"},{"licence":"Temporary"},{"licence":"No"}],"existing_disposal":[{"disposal":"Dry"},{"disposal":"Wet"},{"disposal":"Dry & Wet"},{"disposal":"Other"}],"quality_waste":[{"waste":"Killos"},{"waste":"Tones"}],"type_of_house":[{"type":"Pacca"},{"type":"Semi pacca"},{"type":"Kaccha"}],"type_of_manhole":[{"name":"Man hole"},{"name":"Tree"},{"name":"Bus stop"}],"manhole_type":[{"name":"Minor"},{"name":"Major"}],"type_of_details":[{"name":"Temple"},{"name":"Majid"},{"name":"Church"},{"name":"Yard"},{"name":"Water Tank"},{"name":"Government Property"}],"community_type":[{"name":"Commercial Establishment"},{"name":"Community Hall"}],"toilets_scan_type":[{"name":"Cleaning"},{"name":"Picking Garbage"}],"toilets_scan_reason":[{"name":"Cleaned"},{"name":"Water not available"},{"name":"Damages"}]}

class AllDropDownModel {
  AllDropDownModel({
      this.login, 
      this.status, 
      this.data,});

  AllDropDownModel.fromJson(dynamic json) {
    login = json['login'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? login;
  bool? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// business_type : [{"name":"Kirana shop"},{"name":"Medical shop"},{"name":"Education"},{"name":"Auto mobiles"}]
/// category_type : [{"name":"Business"},{"name":"Residencial"}]
/// licence : [{"licence":"Perminent"},{"licence":"Temporary"},{"licence":"No"}]
/// existing_disposal : [{"disposal":"Dry"},{"disposal":"Wet"},{"disposal":"Dry & Wet"},{"disposal":"Other"}]
/// quality_waste : [{"waste":"Killos"},{"waste":"Tones"}]
/// type_of_house : [{"type":"Pacca"},{"type":"Semi pacca"},{"type":"Kaccha"}]
/// type_of_manhole : [{"name":"Man hole"},{"name":"Tree"},{"name":"Bus stop"}]
/// manhole_type : [{"name":"Minor"},{"name":"Major"}]
/// type_of_details : [{"name":"Temple"},{"name":"Majid"},{"name":"Church"},{"name":"Yard"},{"name":"Water Tank"},{"name":"Government Property"}]
/// community_type : [{"name":"Commercial Establishment"},{"name":"Community Hall"}]
/// toilets_scan_type : [{"name":"Cleaning"},{"name":"Picking Garbage"}]
/// toilets_scan_reason : [{"name":"Cleaned"},{"name":"Water not available"},{"name":"Damages"}]

class Data {
  Data({
      this.businessType, 
      this.categoryType, 
      this.licence, 
      this.existingDisposal, 
      this.qualityWaste, 
      this.typeOfHouse, 
      this.typeOfManhole, 
      this.manholeType, 
      this.typeOfDetails, 
      this.communityType, 
      this.toiletsScanType, 
      this.toiletsScanReason,});

  Data.fromJson(dynamic json) {
    if (json['business_type'] != null) {
      businessType = [];
      json['business_type'].forEach((v) {
        businessType?.add(Business_type.fromJson(v));
      });
    }
    if (json['category_type'] != null) {
      categoryType = [];
      json['category_type'].forEach((v) {
        categoryType?.add(Category_type.fromJson(v));
      });
    }
    if (json['licence'] != null) {
      licence = [];
      json['licence'].forEach((v) {
        licence?.add(Licence.fromJson(v));
      });
    }
    if (json['existing_disposal'] != null) {
      existingDisposal = [];
      json['existing_disposal'].forEach((v) {
        existingDisposal?.add(Existing_disposal.fromJson(v));
      });
    }
    if (json['quality_waste'] != null) {
      qualityWaste = [];
      json['quality_waste'].forEach((v) {
        qualityWaste?.add(Quality_waste.fromJson(v));
      });
    }
    if (json['type_of_house'] != null) {
      typeOfHouse = [];
      json['type_of_house'].forEach((v) {
        typeOfHouse?.add(Type_of_house.fromJson(v));
      });
    }
    if (json['type_of_manhole'] != null) {
      typeOfManhole = [];
      json['type_of_manhole'].forEach((v) {
        typeOfManhole?.add(Type_of_manhole.fromJson(v));
      });
    }
    if (json['manhole_type'] != null) {
      manholeType = [];
      json['manhole_type'].forEach((v) {
        manholeType?.add(Manhole_type.fromJson(v));
      });
    }
    if (json['type_of_details'] != null) {
      typeOfDetails = [];
      json['type_of_details'].forEach((v) {
        typeOfDetails?.add(Type_of_details.fromJson(v));
      });
    }
    if (json['community_type'] != null) {
      communityType = [];
      json['community_type'].forEach((v) {
        communityType?.add(Community_type.fromJson(v));
      });
    }
    if (json['toilets_scan_type'] != null) {
      toiletsScanType = [];
      json['toilets_scan_type'].forEach((v) {
        toiletsScanType?.add(Toilets_scan_type.fromJson(v));
      });
    }
    if (json['toilets_scan_reason'] != null) {
      toiletsScanReason = [];
      json['toilets_scan_reason'].forEach((v) {
        toiletsScanReason?.add(Toilets_scan_reason.fromJson(v));
      });
    }
  }
  List<Business_type>? businessType;
  List<Category_type>? categoryType;
  List<Licence>? licence;
  List<Existing_disposal>? existingDisposal;
  List<Quality_waste>? qualityWaste;
  List<Type_of_house>? typeOfHouse;
  List<Type_of_manhole>? typeOfManhole;
  List<Manhole_type>? manholeType;
  List<Type_of_details>? typeOfDetails;
  List<Community_type>? communityType;
  List<Toilets_scan_type>? toiletsScanType;
  List<Toilets_scan_reason>? toiletsScanReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (businessType != null) {
      map['business_type'] = businessType?.map((v) => v.toJson()).toList();
    }
    if (categoryType != null) {
      map['category_type'] = categoryType?.map((v) => v.toJson()).toList();
    }
    if (licence != null) {
      map['licence'] = licence?.map((v) => v.toJson()).toList();
    }
    if (existingDisposal != null) {
      map['existing_disposal'] = existingDisposal?.map((v) => v.toJson()).toList();
    }
    if (qualityWaste != null) {
      map['quality_waste'] = qualityWaste?.map((v) => v.toJson()).toList();
    }
    if (typeOfHouse != null) {
      map['type_of_house'] = typeOfHouse?.map((v) => v.toJson()).toList();
    }
    if (typeOfManhole != null) {
      map['type_of_manhole'] = typeOfManhole?.map((v) => v.toJson()).toList();
    }
    if (manholeType != null) {
      map['manhole_type'] = manholeType?.map((v) => v.toJson()).toList();
    }
    if (typeOfDetails != null) {
      map['type_of_details'] = typeOfDetails?.map((v) => v.toJson()).toList();
    }
    if (communityType != null) {
      map['community_type'] = communityType?.map((v) => v.toJson()).toList();
    }
    if (toiletsScanType != null) {
      map['toilets_scan_type'] = toiletsScanType?.map((v) => v.toJson()).toList();
    }
    if (toiletsScanReason != null) {
      map['toilets_scan_reason'] = toiletsScanReason?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Cleaned"

class Toilets_scan_reason {
  Toilets_scan_reason({
      this.name,});

  Toilets_scan_reason.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// name : "Cleaning"

class Toilets_scan_type {
  Toilets_scan_type({
      this.name,});

  Toilets_scan_type.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// name : "Commercial Establishment"

class Community_type {
  Community_type({
      this.name,});

  Community_type.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// name : "Temple"

class Type_of_details {
  Type_of_details({
      this.name,});

  Type_of_details.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// name : "Minor"

class Manhole_type {
  Manhole_type({
      this.name,});

  Manhole_type.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// name : "Man hole"

class Type_of_manhole {
  Type_of_manhole({
      this.name,});

  Type_of_manhole.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// type : "Pacca"

class Type_of_house {
  Type_of_house({
      this.type,});

  Type_of_house.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// waste : "Killos"

class Quality_waste {
  Quality_waste({
      this.waste,});

  Quality_waste.fromJson(dynamic json) {
    waste = json['waste'];
  }
  String? waste;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['waste'] = waste;
    return map;
  }

}

/// disposal : "Dry"

class Existing_disposal {
  Existing_disposal({
      this.disposal,});

  Existing_disposal.fromJson(dynamic json) {
    disposal = json['disposal'];
  }
  String? disposal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['disposal'] = disposal;
    return map;
  }

}

/// licence : "Perminent"

class Licence {
  Licence({
      this.licence,});

  Licence.fromJson(dynamic json) {
    licence = json['licence'];
  }
  String? licence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['licence'] = licence;
    return map;
  }

}

/// name : "Business"

class Category_type {
  Category_type({
      this.name,});

  Category_type.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

/// name : "Kirana shop"

class Business_type {
  Business_type({
      this.name,});

  Business_type.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}