/// login : true
/// status : true
/// data : {"business_type":[{"name":"Kirana shop"},{"name":"Medical shop"},{"name":"Education"},{"name":"Auto mobiles"}],"category_type":[{"name":"Business"},{"name":"Residencial"},{"name":"Both"}],"licence":[{"licence":"Perminent"},{"licence":"Temporary"},{"licence":"No"}],"existing_disposal":[{"disposal":"Dry"},{"disposal":"Wet"},{"disposal":"Dry & Wet"},{"disposal":"Other"}],"quality_waste":[{"waste":"Killos"},{"waste":"Tones"}],"type_of_house":[{"type":"Pacca"},{"type":"Semi pacca"},{"type":"Kaccha"}]}

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
/// category_type : [{"name":"Business"},{"name":"Residencial"},{"name":"Both"}]
/// licence : [{"licence":"Perminent"},{"licence":"Temporary"},{"licence":"No"}]
/// existing_disposal : [{"disposal":"Dry"},{"disposal":"Wet"},{"disposal":"Dry & Wet"},{"disposal":"Other"}]
/// quality_waste : [{"waste":"Killos"},{"waste":"Tones"}]
/// type_of_house : [{"type":"Pacca"},{"type":"Semi pacca"},{"type":"Kaccha"}]

class Data {
  Data({
      this.businessType, 
      this.categoryType, 
      this.licence, 
      this.existingDisposal, 
      this.qualityWaste, 
      this.typeOfHouse,});

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
  }
  List<Business_type>? businessType;
  List<Category_type>? categoryType;
  List<Licence>? licence;
  List<Existing_disposal>? existingDisposal;
  List<Quality_waste>? qualityWaste;
  List<Type_of_house>? typeOfHouse;

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