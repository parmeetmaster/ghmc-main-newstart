import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/provider/splash_provider/splash_provider.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/util/security.dart';
import 'package:ghmc/util/share_preferences.dart';
import 'screens/dashboard/dashBordScreen.dart';
import 'util/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkuserLoggedIn() async {

    PermissionUtils().initialisationPermission();
    // initalise all provider global data
    // await SplashProvider.getReference(context).initialisation(context);
    // await DashBoardProvider.getReference(context).initialisation(context);

    //security added here for check device not rooted
    bool isrooted = await Security().check_is_device_rooted();

    if (isrooted == true) {
      "Your Device is root we unable to allow to use Application"
          .showSnackbar(context);
      return;
    }

    String? userdata = await SPreference().getString(login_credentials);

    if (userdata != null) {
      Globals.userData = CredentialsModel.fromRawJson(userdata);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 1),
      () async {
        checkuserLoggedIn();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Mobile splash screen 2.jpg',
      fit: BoxFit.cover,
    );
  }
}
