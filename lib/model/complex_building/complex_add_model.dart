/// status : true
/// data : {"floor":["Basement 1","Basement 2","Basement 3","Ground floor 1","Ground floor 2","Floor 1","Floor 2","Floor 3","Floor 4","Floor 5","Floor 6","Floor 7","Floor 8"],"business_type":[{"name":"Business"},{"name":"Residential"},{"name":"Both"}],"category_type":[{"name":"Category 1"},{"name":"Category 2"},{"name":"Category 3"}],"licence":[{"licence":"Perminent"},{"licence":"Temporary"},{"licence":"No"}],"existing_disposal":[{"disposal":"Dry"},{"disposal":"Wet"},{"disposal":"Dry & Wet"},{"disposal":"Other"}],"quality_waste":[{"waste":"Killos"},{"waste":"Tones"}]}

class ComplexAddModel {
  ComplexAddModel({
      this.status, 
      this.data,});

  ComplexAddModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ComplexData.fromJson(json['data']) : null;
  }
  bool? status;
  ComplexData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// floor : ["Basement 1","Basement 2","Basement 3","Ground floor 1","Ground floor 2","Floor 1","Floor 2","Floor 3","Floor 4","Floor 5","Floor 6","Floor 7","Floor 8"]
/// business_type : [{"name":"Business"},{"name":"Residential"},{"name":"Both"}]
/// category_type : [{"name":"Category 1"},{"name":"Category 2"},{"name":"Category 3"}]
/// licence : [{"licence":"Perminent"},{"licence":"Temporary"},{"licence":"No"}]
/// existing_disposal : [{"disposal":"Dry"},{"disposal":"Wet"},{"disposal":"Dry & Wet"},{"disposal":"Other"}]
/// quality_waste : [{"waste":"Killos"},{"waste":"Tones"}]

class ComplexData {
  ComplexData({
      this.floor, 
      this.businessType, 
      this.categoryType, 
      this.licence, 
      this.existingDisposal, 
      this.qualityWaste,});

  ComplexData.fromJson(dynamic json) {
    floor = json['floor'] != null ? json['floor'].cast<String>() : [];
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
  }
  List<String>? floor;
  List<Business_type>? businessType;
  List<Category_type>? categoryType;
  List<Licence>? licence;
  List<Existing_disposal>? existingDisposal;
  List<Quality_waste>? qualityWaste;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['floor'] = floor;
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

/// name : "Category 1"

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

/// name : "Business"

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