import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/complex_building/circle_complex_access_model.dart';
import 'package:ghmc/model/complex_building/complex_add_model.dart';
import 'package:ghmc/util/extension.dart';
import 'package:provider/provider.dart';

class ComplexBuildingProvider extends ChangeNotifier {
  CircleComplexAccessModel? circleComplexAccessModel;
  ComplexAddModel? complexAddModelDropDown;

  uploadComplexBuilding(FormData data, BuildContext context) async {
    ApiResponse response = await ApiBase().baseFunction(() =>
        ApiBase().getInstance()!.post("/add_complex_building", data: data));
    if (response.status == 200) {
      response.message!.showSnackbar(context);
      return response;
    } else {
      response.message!.showSnackbar(context);
      return response;
    }
  }

  uploadComplexBuildingDetails(FormData data, BuildContext context) async {
    ApiResponse response = await ApiBase().baseFunction(() =>
        ApiBase().getInstance()!.post("/createcomplex_build_two", data: data));
    if (response.status == 200) {
      response.message!.showSnackbar(context);
      return response;
    } else {
      response.message!.showSnackbar(context);
      return response;
    }
  }


  dispose() {
    circleComplexAccessModel = null;
  }

  loadComplexBuilding() async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/getcircleuseraccesscomplex",
            data:
                FormData.fromMap({'user_id': Globals.userData!.data!.userId})));
    circleComplexAccessModel =
        CircleComplexAccessModel.fromJson(response.completeResponse);
    notifyListeners();
  }

  loadComplexBuilingDropDownOptions(String id) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/getcomplex_dropdown", data: FormData.fromMap({'id': id})));
    complexAddModelDropDown =
        ComplexAddModel.fromJson(response.completeResponse);
    notifyListeners();
  }
}
