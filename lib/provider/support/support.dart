import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/support/support_types.dart';
import 'package:ghmc/util/utils.dart';

class SupportProvider extends ChangeNotifier {
  Future<ApiResponse?> getSupporTypes() async {
    ApiResponse response =
        await ApiBase().baseFunction(() => ApiBase().getInstance()!.get(
              "/services_type",
            ));
    return response;
  }

  Future<ApiResponse?> submitComplaint(
      {SupportItems? item,
      TextEditingController? controller,
      File? photo,
      File? recording,
      BuildContext? context}) async {
    if (photo != null) photo = await photo.compressfile;

    Map<String, dynamic> map = {
      'user_id': '${Globals.userData!.data!.userId}',
      'support_list_id': '${item!.id}',
      'description': '${controller!.text}',
    };
    if (photo != null) {
      map.addAll({
        'image': await FileSupport().getMultiPartFromFile(photo),
      });
    }

    if (recording != null) {
      map.addAll({
        'voice_recorder': await FileSupport().getMultiPartFromFile(recording)
      });
    }

    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/add_support", data: FormData.fromMap(map)));
    return response;
  }
}
