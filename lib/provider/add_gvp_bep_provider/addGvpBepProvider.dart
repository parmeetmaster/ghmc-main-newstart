// import 'dart:js';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:provider/provider.dart';

class GvpBepProvider extends ChangeNotifier {
  AwesomeDialog? dialog;

  static GvpBepProvider getInstance(BuildContext context) {
    return Provider.of<GvpBepProvider>(context, listen: false);
  }

  Future<ApiResponse?> addGvpBepData({
    String? userId,
    String? address,
    String? latitude,
    String? longitude,
    String? id,
  }) async {
    ApiResponse response;

    response = await ApiBase().baseFunction(
      () => ApiBase().getInstance()!.post('/add_gvp_bep', data: {
        'user_id': userId,
        'id': id,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      }),
    );
    MProgressIndicator.hide();
    return response;
  }

  Future<ApiResponse?> getGepBepList() async {
    ApiResponse response;
    response = await ApiBase().baseFunction(
      () => ApiBase().getInstance()!.post('/gvp_bep_list', data: {
        'user_id': Globals.userData!.data!.userId,
      }),
    );
    MProgressIndicator.hide();
    return response;
  }

  submit_Gvp_Bep(
      {String? formatted_address,
      String? selected_type,
      Access? selected_ward,
      Access? selected_circle,
      Access? selected_zone,
      GeoHolder? geo_data,
      TextEditingController? landmark_controller,
      TextEditingController? area}) async {
    ApiResponse response;
    selected_type = selected_type!.toLowerCase(); // to lower cases

    response = await ApiBase().baseFunction(
      () => ApiBase().getInstance()!.post('/add_new_gvp_bep', data: {
        'user_id': Globals.userData!.data!.userId,
        'zone': selected_zone!.zoneId,
        'circle': selected_circle!.circleId,
        'ward': selected_ward!.wardId,
        'landmark': landmark_controller!.text,
        'location': formatted_address,
        'area': area!.text,
        'lattitude': geo_data!.position!.latitude!,
        'longitude': geo_data.position!.longitude!,
        'type': selected_type
      }),
    );
    MProgressIndicator.hide();
    return response;
  }
}
