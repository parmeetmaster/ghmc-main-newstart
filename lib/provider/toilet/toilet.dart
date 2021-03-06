import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/all_drop_down_model.dart';

import 'package:ghmc/model/culvert/area_model.dart';
import 'package:ghmc/model/toilet_model/scan_toilet_model.dart';
import 'package:ghmc/provider/add_resident/add_resident_provider.dart';
import 'package:ghmc/provider/community_hall/community_hall.dart';
import 'package:ghmc/provider/complex_building/complex_building.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/util/extension.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/container/camera_container.dart';
import 'package:ghmc/widget/container/map_container.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:provider/provider.dart';

import 'package:ghmc/util/utils.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/all_drop_down_model.dart';
import 'package:ghmc/util/extension.dart';

class ToiletProvider extends ChangeNotifier{
  AllDropDownModel? dropDowns;
  ScanToiletModel? scanToiletModel;

  createToilet(FormData formData, BuildContext context) async {
try{
  ApiResponse response = await ApiBase().baseFunction(() =>
      ApiBase().getInstance()!.post("/createtoilets", data: formData));
  if (response.status == 200) {
    response.message!.showSnackbar(context);
    return response;
  } else {
    response.message!.showSnackbar(context);
    return response;
  }
}catch(e){}
  }


  loadCommunityItems( BuildContext context) async {
    ApiResponse response = await ApiBase().baseFunction(() =>
        ApiBase().getInstance()!.get("/alldropdowns"));
    if (response.status == 200) {
      dropDowns=AllDropDownModel.fromJson(response.completeResponse);
      notifyListeners();
      return response;
    } else {
      response.message!.showSnackbar(context);
      notifyListeners();
      return response;
    }

    notifyListeners();
  }

  void loadResidentDisplayData(qrdata)async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
        "user_id": Globals.userData!.data!.userId,
      "geo_id": qrdata,
    }));
    scanToiletModel=ScanToiletModel.fromJson(response.completeResponse);
    notifyListeners();
  }

  void submitScannedToiletData(FormData formdata, BuildContext context)async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/create_toiletsoperations", data: formdata));

    if(response.status==200){
      response.message!.showSnackbar(context);
      Navigator.pop(context);
    }else{
      response.message!.showSnackbar(context);
    }


    notifyListeners();

  }


}

