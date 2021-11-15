/// uuid : ""
/// memeber_no : ""
/// name : ""
/// gender : ""
/// mobile : ""
/// aadhar : ""
/// age : ""
/// vaccine_type : ""
/// first_dose_yes_no : ""
/// first_dost_date : ""
/// second_dose_yes_no : ""
/// second_dose_date : ""

class CovidSubFormModel {


  CovidSubFormModel({
      this.uuid, 
      this.memeberNo, 
      this.name, 
      this.gender, 
      this.mobile, 
      this.aadhar, 
      this.age,
      this.user_id,
      this.family_member_no,
      this.vaccineType, 
      this.firstDoseYesNo, 
      this.firstDostDate, 
      this.secondDoseYesNo, 
      this.secondDoseDate,});

  CovidSubFormModel.fromJson(dynamic json) {
    uuid = json['uuid'];
    memeberNo = json['memeber_no'];
    name = json['name'];
    user_id = json['user_id'];
    gender = json['gender'];
    mobile = json['mobile'];
    aadhar = json['aadhar'];
    age = json['age'];
    family_member_no = json['family_member_no'];
    vaccineType = json['vaccine_type'];
    firstDoseYesNo = json['first_dose_yes_no'];
    firstDostDate = json['first_dost_date'];
    secondDoseYesNo = json['second_dose_yes_no'];
    secondDoseDate = json['second_dose_date'];
  }
  String? uuid="";
  String? user_id="";
  String? memeberNo="";
  String? family_member_no="";
  String? name="";
  String? gender="";
  String? mobile="";
  String? aadhar="";
  String? age="";
  String? vaccineType="";
  String? firstDoseYesNo="";
  String? firstDostDate="";
  String? secondDoseYesNo="";
  String? secondDoseDate="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = uuid;
    map['user_id'] = user_id;
    map['family_member_no'] = family_member_no;

    map['memeber_no'] = memeberNo;
    map['name'] = name;
    map['gender'] = gender;
    map['mobile'] = mobile;
    map['aadhar'] = aadhar;
    map['age'] = age;
    map['vaccine_type'] = vaccineType;
    map['first_dose_yes_no'] = firstDoseYesNo;
    map['first_dost_date'] = firstDostDate;
    map['second_dose_yes_no'] = secondDoseYesNo;
    map['second_dose_date'] = secondDoseDate;
    return map;
  }

}