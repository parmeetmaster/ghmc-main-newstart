import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/add_vehicle_model/owner_typ.dart';
import 'package:ghmc/model/add_vehicle_model/transfer_station_model.dart';
import 'package:ghmc/model/add_vehicle_model/vehicle_type_model.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/utils.dart';

class AddVehicleProvider with ChangeNotifier {
  String? ion;
  AwesomeDialog? dialog;

  getInstance() {
    return AddVehicleProvider();
  }

  Future<OwnerTypeModel?> getOwnerType() async {
    OwnerTypeModel? ownerType;
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/owner_type"));
    if (response.status == 200)
      ownerType = OwnerTypeModel.fromJson(response.completeResponse);
    return ownerType;
  }

  Future<VehicleTypeModel?> getVehicleType() async {
    VehicleTypeModel? vehicleType;
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/vechiles_type"));
    if (response.status == 200)
      vehicleType = VehicleTypeModel.fromJson(response.completeResponse);
    return vehicleType;
  }

  Future<TransferStationModel?> getTransferStation() async {
    TransferStationModel? transferStationModel;
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/transfer"));
    if (response.status == 200)
      transferStationModel =
          TransferStationModel.fromJson(response.completeResponse);
    return transferStationModel;
  }

  Future<ApiResponse?> uploadVehicleData(
      OwnerTypeDataItem? selectedOwnerType,
      TransferTypeDataItem? selectedTransferType,
      VehicleTypeDataItem? selectedVehicle,
      File? vehicle_image,
      Access access,
      TextEditingController registration_number,
      TextEditingController driver_name,
      BuildContext context,
      TextEditingController phone_number,
      TextEditingController incharge_name,
      TextEditingController incharge_phone_number) async {
    if (selectedOwnerType == null) {
      "Select Owner Type".showSnackbar(context);
      return null;
    } else if (selectedTransferType == null) {
      "Select Transfer Type".showSnackbar(context);
      return null;
    } else if (selectedVehicle == null) {
      "Select vehicle first".showSnackbar(context);
      return null;
    } else if (registration_number.text == null) {
      "Please fill Registration number".showSnackbar(context);
      return null;
    } else if (driver_name.text == null) {
      "Please fill driver name".showSnackbar(context);
      return null;
    } else if (phone_number.text == null) {
      "Please fill phone number".showSnackbar(context);
      return null;
    } else if (incharge_name.text == null) {
      "Please fill Incharge name".showSnackbar(context);
      return null;
    } else if (incharge_phone_number.text == null) {
      "Please fill Incharge phone number".showSnackbar(context);
      return null;
    }

    print("is numeric val ${isNumeric(phone_number.text)}");

    if (isNumeric(phone_number.text) == false) {
      "Phone number may contain alphablets".showSnackbar(context);
      return null;
    }

    if (isNumeric(incharge_phone_number.text) == false) {
      "Phone number may contain alphablets".showSnackbar(context);
      return null;
    }

    if (phone_number.text.length > 10 || phone_number.text.length < 10) {
      "Check Phone number length".showSnackbar(context);
      return null;
    }

    if (incharge_phone_number.text.length > 10 ||
        phone_number.text.length < 10) {
      "Check Phone number length".showSnackbar(context);
      return null;
    }

    FileSupport().getFileSize(file: vehicle_image!)!.printinfo;
    vehicle_image = await vehicle_image.compressfile;
    FileSupport().getFileSize(file: vehicle_image!)!.printinfo;

    MultipartFile? file =
        await FileSupport().getMultiPartFromFile(vehicle_image);

    var map = {
      'user_id': Globals.userData!.data!.userId,
      'zone_id': access.zone,
      'circle_id': access.circleId,
      'ward_id': access.wardId,
      'land_mark_id': access.landmarksId,
      'owner_type_id': selectedOwnerType.id,
      'vechile_type_id': selectedVehicle.id,
      'reg_no': registration_number.text,
      'driver_name': driver_name.text,
      'driver_mobile': phone_number.text,
      'sfa_name': incharge_name.text,
      'sfa_mobile': incharge_phone_number.text,
      'transfer_station_id': selectedVehicle.id,
      'image': file
    };

    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/add_vechile", data: FormData.fromMap(map)));
    if (response.status == 200) {
      //  "vechile added successfully".showSnackbar(context);
      return response;
    } else {
      response.message!.showSnackbar(context);
      return response;
    }
  }

  // post

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
