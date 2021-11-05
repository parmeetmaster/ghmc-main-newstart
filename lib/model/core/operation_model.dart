/// success : true
/// login : true
/// message : "Successfully scanned"
/// data : {"operation":"toilet","operation_code":"TOI1"}

class OperationModel {
  OperationModel({
      this.success, 
      this.login, 
      this.message, 
      this.data,});

  OperationModel.fromJson(dynamic json) {
    success = json['success'];
    login = json['login'];
    message = json['message'];
    data = json['data'] != null ? OperationData.fromJson(json['data']) : null;
  }
  bool? success;
  bool? login;
  String? message;
  OperationData? data;

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

/// operation : "toilet"
/// operation_code : "TOI1"

class OperationData {
  OperationData({
      this.operation, 
      this.operationCode,});

  OperationData.fromJson(dynamic json) {
    operation = json['operation'];
    operationCode = json['operation_code'];
  }
  String? operation;
  String? operationCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['operation'] = operation;
    map['operation_code'] = operationCode;
    return map;
  }

}