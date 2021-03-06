import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/all_drop_down_model.dart';
import 'package:ghmc/model/common_operation/common_flat_operations_model.dart';
import 'package:ghmc/model/common_operation/common_operation_commercial_building.dart';
import 'package:ghmc/model/common_operation/common_operation_community_hall.dart';
import 'package:ghmc/model/common_operation/common_operation_manhole.dart';
import 'package:ghmc/model/common_operation/common_operation_open_places.dart';
import 'package:ghmc/model/common_operation/common_operation_parking.dart';
import 'package:ghmc/model/common_operation/common_operation_resident.dart';
import 'package:ghmc/model/common_operation/common_operation_temple.dart';
import 'package:ghmc/model/common_operation/common_operation_vehicle.dart';
import 'package:ghmc/model/common_operation/common_operation_vendor.dart';

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

class CommonScanProvider extends ChangeNotifier {
  AllDropDownModel? dropDowns;
  CommonOperationResident? commonResidentModel;
  CommonOperationParking? commonParkingModel;
  CommonFlatOperationsModel? commonFlatOperationsModel;
  CommonOperationVendor? commonVendorModel;
  CommonOperationOpenPlaces? commonOperationOpenPlaces;
  CommonOperationManhole? commonOperationManholeModel;
  TempleCommonOperation? templeCommonOperation;
  CommonOperationCommunityHall? commonOperationCommunityHall;
  CommonOperationCommercialBuilding? commonOperationCommercialBuilding;
  CommonOperationVehicle? commonOperationVehicle;
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
  }

  void loadResidentDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonResidentModel =
        CommonOperationResident.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadManholeDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonOperationManholeModel =
        CommonOperationManhole.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadParkingDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonParkingModel =
        CommonOperationParking.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadFlatsDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonFlatOperationsModel =
        CommonFlatOperationsModel.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadVendorDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonVendorModel =
        CommonOperationVendor.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadVehicleDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
      "user_id": Globals.userData!.data!.userId,
      "geo_id": qrdata,
    }));
    commonOperationVehicle =
        CommonOperationVehicle.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadOpenPlaces(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonOperationOpenPlaces =
        CommonOperationOpenPlaces.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadTempleDisplayData(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    templeCommonOperation =
        TempleCommonOperation.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadCommunity(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonOperationCommunityHall =
        CommonOperationCommunityHall.fromJson(response.completeResponse);
    notifyListeners();
  }

  void loadCommericalBuilding(qrdata) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/scan", data: {
              "user_id": Globals.userData!.data!.userId,
              "geo_id": qrdata,
            }));
    commonOperationCommercialBuilding =
        CommonOperationCommercialBuilding.fromJson(response.completeResponse);
    notifyListeners();
  }

  void submitScannedToiletData(FormData formdata, BuildContext context) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/create_toiletsoperations", data: formdata));

    if (response.status == 200) {
      response.message!.showSnackbar(context);
      Navigator.pop(context);
    } else {
      response.message!.showSnackbar(context);
    }

    notifyListeners();
  }

  void submitScannedResidentData(
      FormData formdata, BuildContext context) async {
    MProgressIndicator.show(context);

    ApiResponse response = await ApiBase().baseFunction(() =>
        ApiBase().getInstance()!.post("/createoperations", data: formdata));

    if (response.status == 200) {
      response.message!.showSnackbar(context);
      Navigator.pop(context);
    } else {
      response.message!.showSnackbar(context);
    }
    MProgressIndicator.hide();

    notifyListeners();
  }
}
