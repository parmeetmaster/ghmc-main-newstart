import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/covid_form_model.dart';
import 'package:ghmc/model/resident/resident_member_model.dart';
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

  getUuidFromApi(BuildContext context) async {
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
      int memberindex = 0;
      await getUuidFromApi(context);

      await Future.forEach(covidFamilyArray, (element) async {
        CovidSubFormModel subelement = element as CovidSubFormModel;
        subelement.uuid = residentFirstTimeUuidModel!.data!;
        subelement.user_id = Globals.userData!.data!.userId!;
        subelement.family_member_no = Uuid().v4();
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

  Future<List<CovidSubFormModel>?> getMemberUsingUuid(String? uuid, RESIDENT_OPR? resident_opr) async {
    ResidentMemberModel residentMemberModel;

    try {
      if (resident_opr == null || resident_opr == RESIDENT_OPR.insert) {
        return null;
      } else if (resident_opr == RESIDENT_OPR.update) {
        residentFirstTimeUuidModel = ResidentUuidModel(data: uuid);
        ApiResponse response = await ApiBase().baseFunction(
            () => ApiBase().getInstance()!.post("/get_all_family",data: {"uuid":uuid}));
        if (response.status == 200) {
          residentMemberModel =
              ResidentMemberModel.fromJson(response.completeResponse);
          List<CovidSubFormModel> covidData = [];
          int i = 0;
       await   Future.forEach(residentMemberModel.data!, (e) {
            CovidElement element =e as CovidElement;
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

  removeMember(CovidSubFormModel covidModel) {




  }
}
