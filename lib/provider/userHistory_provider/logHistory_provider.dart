import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';

class LogHistoryProvider extends ChangeNotifier {
  Future<ApiResponse?> getLogHistory() async {
    ApiResponse response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.post("/log_history", data: {
              "user_id": Globals.userData!.data!.userId!,
            }));
    return response;
  }

  Future<ApiResponse?> absentVehicles(String? value) async {
    ApiResponse response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.post("/absent_vehicles", data: {
              "user_id": Globals.userData!.data!.userId!,
              "date": DateTime.now(),
              "vehicle_type": value,
            }));
    return response;
  }

  Future<ApiResponse?> absentVehiclesComment(String id, String comment) async {
    ApiResponse response = await ApiBase().baseFunction(
            () => ApiBase().getInstance()!.post("/absent_vehicles_coment", data: {
          "user_id": Globals.userData!.data!.userId!,
          "id" : id,
          "date": DateTime.now(),
          "comment": comment,
        }));
    return response;
  }
}
