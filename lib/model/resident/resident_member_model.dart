/// status : true
/// data : [{"user_id":"60f7d3fbd6eb5d0e1019ffff","uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","name":"Sai","age":25,"gender":"Male","mobile":9032771453,"aadhar":1428793364146845,"vaccine_type":"COVI Shield","created_by":"60f7d3fbd6eb5d0e1019ffff","date":"15-11-2021","family_member_no":"142852","first_dose_yes_no":"Yes","first_dost_date":"2021-02-14","second_dose_yes_no":"Yes","second_dose_date":"2021-02-14"},{"user_id":"60f7d3fbd6eb5d0e1019ffff","uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","name":"Sai Kumar","age":25,"gender":"Male","mobile":9032771453,"aadhar":1428793364146845,"vaccine_type":"COVI Shield","created_by":"60f7d3fbd6eb5d0e1019ffff","date":"15-11-2021","family_member_no":"14875","first_dose_yes_no":"Yes","first_dost_date":"2021-02-14","second_dose_yes_no":"Yes","second_dose_date":"2021-02-14"},{"user_id":"60f7d3fbd6eb5d0e1019ffff","uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","name":"Vivek Kumar","age":25,"gender":"Male","mobile":9032771453,"aadhar":1428793364146845,"vaccine_type":"COVI Shield","created_by":"60f7d3fbd6eb5d0e1019ffff","date":"15-11-2021","family_member_no":"14875785252","first_dose_yes_no":"Yes","first_dost_date":"2021-02-14","second_dose_yes_no":"Yes","second_dose_date":"2021-02-14"},{"user_id":"60f7d3fbd6eb5d0e1019ffff","uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","name":"Vivek Kumar","age":25,"gender":"Male","mobile":9032771453,"aadhar":1428793364146845,"vaccine_type":"COVI Shield","created_by":"60f7d3fbd6eb5d0e1019ffff","date":"15-11-2021","family_member_no":"1487578527","first_dose_yes_no":"Yes","first_dost_date":"2021-02-14","second_dose_yes_no":"Yes","second_dose_date":"2021-02-25"},{"user_id":"60f7d3fbd6eb5d0e1019ffff","uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","name":"Sai Prakash","age":35,"gender":"Male","mobile":9032771453,"aadhar":1428793364146845,"vaccine_type":"COVI Shield","created_by":"60f7d3fbd6eb5d0e1019ffff","date":"15-11-2021","family_member_no":"147852","first_dose_yes_no":"Yes","first_dost_date":"2021-02-14","second_dose_yes_no":"Yes","second_dose_date":"2021-02-14"},{"user_id":"60f7d3fbd6eb5d0e1019ffff","uuid":"oF_ZkDQJs6f_YONiZ7VvZHGtU","name":"Sai Prakash","age":35,"gender":"Male","mobile":9032771453,"aadhar":1428793364146845,"vaccine_type":"COVI Shield","created_by":"60f7d3fbd6eb5d0e1019ffff","date":"15-11-2021","family_member_no":"1478568","first_dose_yes_no":"Yes","first_dost_date":"2021-02-14","second_dose_yes_no":"Yes","second_dose_date":"2021-02-14"}]
/// uuid : "oF_ZkDQJs6f_YONiZ7VvZHGtU"
/// message : "success"

class ResidentMemberModel {
  ResidentMemberModel({
      this.status, 
      this.data, 
      this.uuid, 
      this.message,});

  ResidentMemberModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CovidElement.fromJson(v));
      });
    }
    uuid = json['uuid'];
    message = json['message'];
  }
  bool? status;
  List<CovidElement>? data;
  String? uuid;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['uuid'] = uuid;
    map['message'] = message;
    return map;
  }

}

/// user_id : "60f7d3fbd6eb5d0e1019ffff"
/// uuid : "oF_ZkDQJs6f_YONiZ7VvZHGtU"
/// name : "Sai"
/// age : 25
/// gender : "Male"
/// mobile : 9032771453
/// aadhar : 1428793364146845
/// vaccine_type : "COVI Shield"
/// created_by : "60f7d3fbd6eb5d0e1019ffff"
/// date : "15-11-2021"
/// family_member_no : "142852"
/// first_dose_yes_no : "Yes"
/// first_dost_date : "2021-02-14"
/// second_dose_yes_no : "Yes"
/// second_dose_date : "2021-02-14"

class CovidElement {
  CovidElement({
      this.userId, 
      this.uuid, 
      this.name, 
      this.age, 
      this.gender, 
      this.mobile, 
      this.aadhar, 
      this.vaccineType, 
      this.createdBy, 
      this.date, 
      this.familyMemberNo, 
      this.firstDoseYesNo, 
      this.firstDostDate, 
      this.secondDoseYesNo, 
      this.secondDoseDate,});

  CovidElement.fromJson(dynamic json) {
    userId = json['user_id'];
    uuid = json['uuid'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    mobile = json['mobile'];
    aadhar = json['aadhar'];
    vaccine_yes_no = json['vaccine_yes_no'];
    vaccineType = json['vaccine_type'];
    createdBy = json['created_by'];
    date = json['date'];
    familyMemberNo = json['family_member_no'];
    firstDoseYesNo = json['first_dose_yes_no'];
    firstDostDate = json['first_dost_date'];
    secondDoseYesNo = json['second_dose_yes_no'];
    secondDoseDate = json['second_dose_date'];
  }
  String? userId;
  String? uuid;
  String? name;
  int? age;
  String? gender;
  int? mobile;
  int? aadhar;
  String? vaccineType;
  String? vaccine_yes_no;
  String? createdBy;
  String? date;
  String? familyMemberNo;
  String? firstDoseYesNo;
  String? firstDostDate;
  String? secondDoseYesNo;
  String? secondDoseDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['uuid'] = uuid;
    map['vaccine_yes_no'] = vaccine_yes_no;
    map['name'] = name;
    map['age'] = age;
    map['gender'] = gender;
    map['mobile'] = mobile;
    map['aadhar'] = aadhar;
    map['vaccine_type'] = vaccineType;
    map['created_by'] = createdBy;
    map['date'] = date;
    map['family_member_no'] = familyMemberNo;
    map['first_dose_yes_no'] = firstDoseYesNo;
    map['first_dost_date'] = firstDostDate;
    map['second_dose_yes_no'] = secondDoseYesNo;
    map['second_dose_date'] = secondDoseDate;
    return map;
  }

}