import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  static SplashProvider getReference(BuildContext context) {
    return Provider.of<SplashProvider>(context, listen: false);
  }

  Future<ApiResponse?> validateToken() async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/token_validate"));
    return response;
  }
  //
  // initialisation(BuildContext context) async {
  //   // await DashBoardProvider.getReference(context).setZones();
  //   await DashBoardProvider.getReference(context).setVehicleType();
  //   await DashBoardProvider.getReference(context).setTransferStation();
  // }
}

// set_zones
