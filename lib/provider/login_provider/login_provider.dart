import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/util/share_preferences.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

import '../../screens/dashboard/dashBordScreen.dart';

class LoginProvider extends ChangeNotifier {
  static CredentialsModel? user;

  static LoginProvider getInstance(BuildContext context) {
    return Provider.of<LoginProvider>(context, listen: false);
  }

  // call at time of input qr code
  performLogin(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) async {
    MProgressIndicator.show(context);

    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/login", data: {
              "identity": emailController.text.toString(),
              "password": passwordController.text.toString(),
              "fcm_token": fcmToken,
            }));
    MProgressIndicator.hide();
    if (response.status != 200) {
      LoginError.fromJson(response.completeResponse)
          .message!
          .showSnackbar(context);
      return;
    }

    user = CredentialsModel.fromJson(response.completeResponse);
    Globals.userData = user!; // setting up user on login
    await SPreference().setString(login_credentials, user!.toRawJson())!;

    "Login Successfully".showSnackbar(context);

    Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
        ),
      );
    });
  }

  Future<ApiResponse> update_password(
      {TextEditingController? old_password,
      TextEditingController? new_password,
      TextEditingController? new_confirm_password}) async {
    ApiResponse response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.post("/change_password", data: {
              "user_id": Globals.userData!.data!.userId,
              "password": old_password!.text,
              "new_password": new_password!.text,
              "confirm_password": new_confirm_password!.text,
            }));
    MProgressIndicator.hide();
    return response;
  }

  logout(context) async {
    Globals.userData = null;
    await SPreference().clear();
    Phoenix.rebirth(context);
  }
}
