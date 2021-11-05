import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';

class MapLocationProvider extends ChangeNotifier {
  Future<ApiResponse?> vehiclesLocations() async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/mapgvpbvp", data: {
              "user_id": Globals.userData!.data!.userId!,
              "date": DateTime.now(),
            }));
    return response;
  }
}
