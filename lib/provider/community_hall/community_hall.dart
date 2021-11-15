import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/all_drop_down_model.dart';
import 'package:ghmc/model/resident/resident_uuid_model.dart';
import 'package:ghmc/util/extension.dart';

class CommunityHallProvider extends ChangeNotifier {
  AllDropDownModel? dropDowns;

  uploadCommunityHall(FormData data, BuildContext context) async {
    try {
      ApiResponse response = await ApiBase().baseFunction(() =>
          ApiBase().getInstance()!.post("/createcommunityhall", data: data));
      if (response.status == 200) {
        response.message!.showSnackbar(context);
        return response;
      } else {
        response.message!.showSnackbar(context);
        return response;
      }
    } catch (e) {}
  }

  loadCommunityItems(BuildContext context) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/alldropdowns"));
    if (response.status == 200) {
      dropDowns = AllDropDownModel.fromJson(response.completeResponse);
      notifyListeners();
      return response;
    } else {
      response.message!.showSnackbar(context);
      notifyListeners();
      return response;
    }

    notifyListeners();
  }




}
