import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/covid_form_model.dart';
import 'package:ghmc/model/resident/resident_member_model.dart';
import 'package:ghmc/model/resident/resident_pre_submit_detial_model.dart';
import 'package:ghmc/model/resident/resident_search_response_model.dart';
import 'package:ghmc/model/resident/resident_uuid_model.dart';
import 'package:ghmc/screens/add_resident/add_resident.dart';
import 'package:ghmc/util/extension.dart';
import 'package:ghmc/widget/pagination/pagination_covid_form.dart';
import 'package:uuid/uuid.dart';

class ResidentProvider extends ChangeNotifier {
  ResidentUuidModel? residentFirstTimeUuidModel;
  ResidentSearchResponseModel? residentSearchResponseModel;
  CovidFormController covidFormController = new CovidFormController();
  ResidentPreSubmitDetialModel? prefillModel;
  List<CovidSubFormModel> covidModel = [];
  performAddResident(FormData formData, BuildContext context) async {
    try {
      formData.fields.add(MapEntry("uuid", residentFirstTimeUuidModel!.data!));
      ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
          .getInstance()!
          .post("/createresidential_house", data: formData));
      if (response.status == 200) {
        response.message!.showSnackbar(context);
        return response;
      } else {
        response.message!.showSnackbar(context);
        return response;
      }
    } catch (e) {}
  }

  getPrefillResidentDetails(BuildContext context, uuid) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/residential_details",
            data: FormData.fromMap({'uuid': uuid??""})));
    if (response.status == 200) {
      prefillModel =
          ResidentPreSubmitDetialModel.fromJson(response.completeResponse);
      notifyListeners();
      return response;
    } else {
      response.message!.showSnackbar(context);
      notifyListeners();
      return response;
    }
  }

  getUuidFromApi(BuildContext context, String? uuid) async {
    if (uuid != null) {
      residentFirstTimeUuidModel = ResidentUuidModel();
      residentFirstTimeUuidModel!.data = uuid;
      "Api is not called due to update".printerror;
      return;
    }

    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/getuuid"));
    if (response.status == 200) {
      residentFirstTimeUuidModel =
          ResidentUuidModel.fromJson(response.completeResponse);
      notifyListeners();
      return response;
    } else {
      response.message!.showSnackbar(context);
      notifyListeners();
      return response;
    }
  }

  Future<bool> submitCovidDataFirstTime(BuildContext context) async {
  try {
      List<CovidSubFormModel> covidFamilyArray =
          await covidFormController.getCovidFamilyData!();
      "This is data size from covid form${covidFamilyArray.length}".printinfo;

      for (int i = 0; i < covidFamilyArray.length; i++) {
        CovidSubFormModel subelement = covidFamilyArray[i];
        if (subelement.secondDoseDate!.isEmpty) {
          "Second dose date wont empty".showSnackbar(context);

          return false;
        } else if (subelement.name!.isEmpty) {
          "Name wont empty".showSnackbar(context);
          return false;
        } else if (subelement.firstDostDate!.isEmpty) {
          "Fiest dose date wont empty".showSnackbar(context);
          return false;
        } else if (subelement.aadhar!.isEmpty) {
          "Adhaar wont empty".showSnackbar(context);
          return false;
        } else if (subelement.mobile!.isEmpty) {
          "Mobile date wont empty".showSnackbar(context);
          return false;
        } else if (subelement.vaccineType!.isEmpty) {
          "Vaccine Type wont empty".showSnackbar(context);
          return false;
        } else if (subelement.age!.isEmpty) {
          "Age wont empty".showSnackbar(context);
          return false;
        } else if (subelement.gender!.isEmpty) {
          "Gender wont empty".showSnackbar(context);
          return false;
        }
      }

      int memberindex = 0;

      await Future.forEach(covidFamilyArray, (element) async {
        CovidSubFormModel subelement = element as CovidSubFormModel;
        subelement.uuid = residentFirstTimeUuidModel!.data!;
        subelement.user_id = Globals.userData!.data!.userId!;

        if (subelement.family_member_no == null ||
            subelement.family_member_no!.isEmpty) {
          subelement.family_member_no = Uuid().v4();
        }

        ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
            .getInstance()!
            .post("/family_members",
                data: FormData.fromMap((subelement.toJson()))));
        if (response.status == 200) {
          "${memberindex} family data added";
        } else {
          "${response.message!} in Member ${memberindex + 1} form"
              .showSnackbar(context);
          return false;
        }
        memberindex++;
      });
    } catch (e) {
      e.toString().showSnackbar(context);
      return false;
    }
    residentUpdate();
    return true;
  }

  Future<ApiResponse> searchResident(String phno, BuildContext context) async {
    this.residentSearchResponseModel = null;
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/residential_search", data: {'search': phno}));
    if (response.status == 200) {
      residentSearchResponseModel =
          ResidentSearchResponseModel.fromJson(response.completeResponse);
      notifyListeners();

      return response;
    } else {
      response.message!.showSnackbar(context);
      notifyListeners();
      return response;
    }
  }

  void residentUpdate() async {
    try {
      ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
          .getInstance()!
          .post("/residential_family_update",
              data: {'uuid': residentFirstTimeUuidModel!.data!}));
      if (response.status == 200) {
        residentSearchResponseModel =
            ResidentSearchResponseModel.fromJson(response.completeResponse);
        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (e) {
      e.toString().printerror;
    }
  }

  Future<List<CovidSubFormModel>?> getMemberUsingUuid(
      String? uuid, RESIDENT_OPR? resident_opr) async {
    ResidentMemberModel residentMemberModel;

    try {
      if (resident_opr == null || resident_opr == RESIDENT_OPR.insert) {
        return null;
      } else if (resident_opr == RESIDENT_OPR.update) {
        residentFirstTimeUuidModel = ResidentUuidModel(data: uuid);
        ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
            .getInstance()!
            .post("/get_all_family", data: {"uuid": uuid}));
        if (response.status == 200) {
          residentMemberModel =
              ResidentMemberModel.fromJson(response.completeResponse);
          List<CovidSubFormModel> covidData = [];
          int i = 0;
          await Future.forEach(residentMemberModel.data!, (e) {
            CovidElement element = e as CovidElement;
            covidData.add(CovidSubFormModel(
              user_id: element.userId,
              uuid: element.uuid,
              memeberNo: (i++).toString(),
              name: element.name,
              gender: element.gender,
              mobile: element.mobile.toString(),
              aadhar: element.aadhar.toString(),
              age: element.age.toString(),
              family_member_no: element.familyMemberNo,
              vaccineType: element.vaccineType,
              firstDoseYesNo: element.firstDoseYesNo,
              firstDostDate: element.firstDostDate,
              secondDoseYesNo: element.secondDoseYesNo,
              secondDoseDate: element.secondDoseDate,
            ));
          });

          return covidData;

          notifyListeners();
        } else {
          //response.message!.showSnackbar(context);
          notifyListeners();
        }
      }
    } catch (e) {
      e.toString().printerror;
    }
  }

  removeMember(CovidSubFormModel covidModel) {}
}
