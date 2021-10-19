import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/add_vehicle_model/owner_typ.dart';
import 'package:ghmc/model/add_vehicle_model/transfer_station_model.dart';
import 'package:ghmc/model/add_vehicle_model/vehicle_type_model.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/utils.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:ghmc/util/utils.dart';

class AddDataProvider extends ChangeNotifier {
  uploadTransferStation(
      BuildContext context,
      TransferTypeDataItem? selected_transferStation,
      LocationData? location,
      File? photo) async {
    String? state = await GeoUtils().getStateName(context);
    if (state == null) {
      "Please check Location not grabbed".showSnackbar(context);
      return;
    }

    photo = await photo!.compressfile; // compression added

    MultipartFile? file = await FileSupport().getMultiPartFromFile(photo!);

// todo need to update data
    Map<String, dynamic> map = {
      'user_id': Globals.userData!.data!.userId,
      'transfer_station_id': selected_transferStation!.id,
      'address': state,
      'latitude': " ${location!.latitude}",
      'longitude': "${location.longitude}",
      'image': file,
    };

    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/add_transfer_station", data: FormData.fromMap(map)));
    if (response.status == 200) {
      //  response.message!.showSnackbar(context);
      return response;
    } else {
      //response.message!.showSnackbar(context);
      return response;
    }
  }
}
