import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/culvert/area_model.dart';
import 'package:ghmc/model/culvert/culvert_issue.dart';
import 'package:ghmc/model/culvert/culvert_issue_item_zone_wise.dart';
import 'package:ghmc/model/culvert/culvert_issue_name.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:location/location.dart';

import 'package:location_platform_interface/location_platform_interface.dart';

class CulvertProvider extends ChangeNotifier {

  Future<ApiResponse?> getZones() async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/zones_list",
            data: {"user_id": Globals.userData!.data!.userId}));
    return response;
  }

  Future<ApiResponse?> getCircles(DataItem dataItem) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
            .getInstance()!
            .post("/circle", data: {
          "zone_id": dataItem.id,
          "user_id": Globals.userData!.data!.userId
        }));
    MProgressIndicator.hide();
    return response;
  }

  Future<ApiResponse?> getWards(DataItem? selected_circle) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
            .getInstance()!
            .post("/wards", data: {
          "circle_id": selected_circle!.id,
          "user_id": Globals.userData!.data!.userId
        }));
    MProgressIndicator.hide();
    return response;
  }

  Future<ApiResponse?> getAreas(DataItem dataItem) async {
    ApiResponse response = await ApiBase().baseFunction(() =>
        ApiBase().getInstance()!.post("/area", data: {"ward_id": dataItem.id}));
    MProgressIndicator.hide();
    return response;
  }

  Future<ApiResponse?> getLandmarks(DataItem dataItem) async {
    ApiResponse response = await ApiBase().baseFunction(() =>
        ApiBase().getInstance()!.post("/getareawiselandmark", data: {"area_id": dataItem.id}));
    MProgressIndicator.hide();
    return response;
  }

  Future<ApiResponse> add_culvert({
    required String? ward,
    required String? area,
    required String landmark,
    required String culvert_name,
    required String culvertType,
    required String depth,
    LocationData? location,
    required String location_format_address,
  }) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/culvert", data: {
              'user_id': Globals.userData!.data!.userId,
              'zone_id': Globals.userData!.data!.access!.first.zoneId,
              'circle_id': Globals.userData!.data!.access!.first.circleId,
              'ward_id': ward,
              'landmark': landmark,
              'latittude': location!.latitude,
              'longitude': location.longitude,
              'location': location_format_address,
              'area': area,
              'type': culvertType,
              'name': culvert_name,
              'depth': depth,
            }));
    MProgressIndicator.hide();

    return response;
  }

  Future<ApiResponse> submit({
    QrDataModel? model,
    File? photo,
    String? depth,
    CulvertIssueNameItem? culvertIssueName,
  }) async {
    Map<String, dynamic> map = {
      'user_id': '${Globals.userData!.data!.userId}',
      'culvert_id': '${model!.data!.culvertId}',
      'image': await FileSupport().getMultiPartFromFile(photo!),
      'isse_type_id': '${culvertIssueName!.id}',
      'depth': depth,
    };

    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/culvertissue", data: FormData.fromMap(map)));
    MProgressIndicator.hide();
    return response;
  }

  // culvert issues scrreen with qr
  Future<ApiResponse?> getCulvertIssuesTypes() async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/culvertissue_type",
            data: {"user_id": Globals.userData!.data!.userId}));
    return response;
  }

  // culvert issues scrreen with qr
  Future<ApiResponse?> getIssuesZoneWise() async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/getallissueszonewise",
            data: {"user_id": Globals.userData!.data!.userId}));
    return response;
  }

  Future<ApiResponse?> submitCulvertIssue(CulvertDataItem data) async {
    File? compress_image = await FileSupport().compressImage(data.statusImage!);

    LocationData? location = await CustomLocation().getLocation();

    Map<String, dynamic> map = {
      'culvert_id': data.culvertId,
      'culvert_issue_id': data.id,
      'user_id': Globals.userData!.data!.userId,
      'status': data.updatedStatus,
      'image': await FileSupport().getMultiPartFromFile(compress_image!),
      'latitude': location!.latitude,
      'longitude': location.longitude,
    };

    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/culvertsolved", data: FormData.fromMap(map)));
    MProgressIndicator.hide();
    return response;
  }
}
