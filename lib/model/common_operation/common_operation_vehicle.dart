/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"col_id":"61a228f7dd6aa57db5637283","owner_type":"Private","vechile_type":"GHMC Swatch Auto","vechile_no":"Ap08x1205","driver_name":"Hari","driver_no":"8521479635","address":" ","landmark":"Ajmath Nagar-Ajmath Nagar","ward_name":"Chilka Nagar","circle":"Uppal","zone":"Lb Nagar","created_date":"2021-11-30T16:13:40.286Z","date_time":"2021-11-30T16:13:40.286Z","geo_id":"OqSDHaNElIvFdHPAVerQ5reQJ","scan_type":"vehicle","db_type":"vehicle","type":"vehicle","depth":"","culvert_id":"","culvert_type":"","culvert_name":"","area":"","distance":""}

class CommonOperationVehicle {
  CommonOperationVehicle({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  CommonOperationVehicle.fromJson(dynamic json) {
    success = json['success'];
    login = json['login'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  bool? login;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['login'] = login;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// col_id : "61a228f7dd6aa57db5637283"
/// owner_type : "Private"
/// vechile_type : "GHMC Swatch Auto"
/// vechile_no : "Ap08x1205"
/// driver_name : "Hari"
/// driver_no : "8521479635"
/// address : " "
/// landmark : "Ajmath Nagar-Ajmath Nagar"
/// ward_name : "Chilka Nagar"
/// circle : "Uppal"
/// zone : "Lb Nagar"
/// created_date : "2021-11-30T16:13:40.286Z"
/// date_time : "2021-11-30T16:13:40.286Z"
/// geo_id : "OqSDHaNElIvFdHPAVerQ5reQJ"
/// scan_type : "vehicle"
/// db_type : "vehicle"
/// type : "vehicle"
/// depth : ""
/// culvert_id : ""
/// culvert_type : ""
/// culvert_name : ""
/// area : ""
/// distance : ""

class Data {
  Data({
      this.colId, 
      this.ownerType, 
      this.vechileType, 
      this.vechileNo, 
      this.driverName, 
      this.driverNo, 
      this.address, 
      this.landmark, 
      this.wardName, 
      this.circle, 
      this.zone, 
      this.createdDate, 
      this.dateTime, 
      this.geoId, 
      this.scanType, 
      this.dbType, 
      this.type, 
      this.depth, 
      this.culvertId, 
      this.culvertType, 
      this.culvertName, 
      this.area, 
      this.distance,});

  Data.fromJson(dynamic json) {
    colId = json['col_id'];
    ownerType = json['owner_type'];
    vechileType = json['vechile_type'];
    vechileNo = json['vechile_no'];
    driverName = json['driver_name'];
    driverNo = json['driver_no'];
    address = json['address'];
    landmark = json['landmark'];
    wardName = json['ward_name'];
    circle = json['circle'];
    zone = json['zone'];
    createdDate = json['created_date'];
    dateTime = json['date_time'];
    geoId = json['geo_id'];
    scanType = json['scan_type'];
    dbType = json['db_type'];
    type = json['type'];
    depth = json['depth'];
    culvertId = json['culvert_id'];
    culvertType = json['culvert_type'];
    culvertName = json['culvert_name'];
    area = json['area'];
    distance = json['distance'];
  }
  String? colId;
  String? ownerType;
  String? vechileType;
  String? vechileNo;
  String? driverName;
  String? driverNo;
  String? address;
  String? landmark;
  String? wardName;
  String? circle;
  String? zone;
  String? createdDate;
  String? dateTime;
  String? geoId;
  String? scanType;
  String? dbType;
  String? type;
  String? depth;
  String? culvertId;
  String? culvertType;
  String? culvertName;
  String? area;
  String? distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['col_id'] = colId;
    map['owner_type'] = ownerType;
    map['vechile_type'] = vechileType;
    map['vechile_no'] = vechileNo;
    map['driver_name'] = driverName;
    map['driver_no'] = driverNo;
    map['address'] = address;
    map['landmark'] = landmark;
    map['ward_name'] = wardName;
    map['circle'] = circle;
    map['zone'] = zone;
    map['created_date'] = createdDate;
    map['date_time'] = dateTime;
    map['geo_id'] = geoId;
    map['scan_type'] = scanType;
    map['db_type'] = dbType;
    map['type'] = type;
    map['depth'] = depth;
    map['culvert_id'] = culvertId;
    map['culvert_type'] = culvertType;
    map['culvert_name'] = culvertName;
    map['area'] = area;
    map['distance'] = distance;
    return map;
  }

}