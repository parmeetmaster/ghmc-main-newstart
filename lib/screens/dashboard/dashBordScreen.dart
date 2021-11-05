import 'dart:async';
import 'dart:io' show File, Platform;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/model/validateTokenModel.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/provider/splash_provider/splash_provider.dart';
import 'package:ghmc/screens/dashboard/dashbaord/scanDataScreen.dart';
import 'package:ghmc/screens/errors/14_no_result_found.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/util/open_camera.dart';
import 'package:ghmc/util/permission.dart';
import 'package:ghmc/util/qrcode_screen.dart';
import 'package:ghmc/widget/drawer.dart';
import 'package:ghmc/util/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import 'dashbaord/dashboard_body.dart';
import 'map_button_screen/gvp_bep_map.dart';

enum WhatToDo { qrscan }

class DashBoardScreen extends StatefulWidget {
  CredentialsModel? credentialsModel;

  dynamic operation;

  DashBoardScreen({Key? key, dynamic? operaton = null}) {
    credentialsModel = Globals.userData;
    this.operation = operaton;
  }

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  LatLng? currentPostion;

  late AwesomeDialog dialog;

  int _activeIndex = 0;
  File? vehicle_image;

  bool onSubmit = false;

  ValidateTokenModel? data;

  Future<void> _getValidateToken() async {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    ApiResponse? resp = await splashProvider.validateToken();
    if (resp!.status != 200) {
      print('${resp.completeResponse}');
      if (resp.status!>=400) {
        "Server not responding".showSnackbar(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }

      data = ValidateTokenModel.fromJson(resp.completeResponse);
      if (data!.login == false && data!.success == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([_getValidateToken()]);
    // PermissionUtils().initialisationPermission();
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      print("WidgetsBinding");
    });

    //🎰 it call function when build is complete
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        if (widget.operation != null) {
          if (widget.operation == WhatToDo.qrscan) {
            _scan();
          }
        }
      },
    );

    final provider = DashBoardProvider.getReference(context);
    provider.setAuthentications();
    // provider.checkNearGepBep(context);
  }

  @override
  void didChangeDependencies() {
    final provider = DashBoardProvider.getReference(context);
    provider.checkNearGepBep(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // its for qr scan from multiple screens

    int activetab;

/*    final scanResult = this.scanResult;*/

    return Consumer<DashBoardProvider>(
      builder: (context, value, child) {
        if (Globals.authority != null) {
          if (Globals.authority!.data == null) {
            return Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF9C27B0),
                        Color(0xFFF06292),
                        Color(0xFFFF5277),
                      ],
                    ),
                  ),
                ),
                title: const Text('Dash Board'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'User is not authorised please logout',
                      style: new TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradientText,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF5277),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          'LogOut',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        dialog = AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Logout',
                          desc: 'User not authorised..!',
                          btnOkOnPress: () async {
                            await LoginProvider.getInstance(context)
                                .logout(context);
                          },
                        )..show();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            drawer: MainDrawer(),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF9C27B0),
                      Color(0xFFF06292),
                      Color(0xFFFF5277),
                    ],
                  ),
                ),
              ),
              title: const Text('Dash Board'),
              actions: [
                if (value.is_any_gep_bep == null ||
                    value.is_any_gep_bep == false)
                  IconButton(
                    icon: const Icon(
                      Icons.map,
                      color: Colors.white,
                    ),
                    tooltip: 'Map',
                    onPressed: () {},
                  ),
                if (value.is_any_gep_bep == true)
                  IconButton(
                    icon: const Icon(
                      Icons.map,
                      color: Colors.green,
                    ),
                    tooltip: 'Map',
                    onPressed: () {
                      GvpBepMap().push(context);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  tooltip: 'Qr Scan',
                  onPressed: _scan,
                ),
              ],
            ),
            body: Globals.authority!.data!.first.dashboard == true
                ? DashBoardBody()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/sanitation.png'),
                        Text(
                          'Welcome to GHMC Sanitization',
                          style: new TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradientText),
                        ),
                      ],
                    ),
                  ),
          );
        } else if (Globals.authority == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  //get current location
  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPostion = LatLng(
        position.latitude,
        position.longitude,
      );
    });
  }

  // code to invoke scan in flutter
  _scan() async {
    if (PermissionUtils().isCameraEnable() == false) {
      await "Please give Camera Permission".showSnackbar(context);
      Future.delayed(Duration(seconds: 5)).then(
          (value) async => await PermissionUtils().initialisationPermission());
      return;
    }
    _getUserLocation();

    String? current_Longitude = '${currentPostion!.longitude}';
    String? current_Latitude = '${currentPostion!.latitude}';

    String qrdata = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScreen(),
      ),
    );

    bool operation = await DashBoardProvider.getReference(context).performQrAction(
      context: context,
      id: widget.credentialsModel!.data!.userId!,
      qrdata: qrdata,
      latitude: current_Latitude,
      longitude: current_Longitude,
    );

    if(operation==true){
      return;
    }

    MProgressIndicator.show(context);
    print("QR DATA IS : $qrdata");
    Globals.userData!.data!.userId!.printwtf;
    print(Globals.userData!.data!.departmentId);
    ApiResponse? model;
    if(Globals.userData!.data!.departmentId =="60f75d6885af0530888ff185")
    {
      print("hello : $qrdata");
      model = await DashBoardProvider.getReference(context).getDriverData(
        id: widget.credentialsModel!.data!.userId!,
        qrdata: qrdata,
        latitude: current_Latitude,
        longitude: current_Longitude,
      );
    } else if (Globals.userData!.data!.departmentId == "4")
    {
      //see if user is transfer manager
      model = await DashBoardProvider.getReference(context)
          .getTransferStationManager(
              widget.credentialsModel!.data!.userId!, qrdata);
    }
    else if (Globals.userData!.data!.departmentId != "4")
    {
      //see if user is culert eligible
      model = await DashBoardProvider.getReference(context)
          .getCulvertData(widget.credentialsModel!.data!.userId!, qrdata);
    }
    print(" here is data${model!.status}");
    print(" here is data${Globals.userData!.data!.departmentId }");
    if (model.status != 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoResultFoundScreen(),
        ),
      );
    }

    MProgressIndicator.hide();
    if (model.status != 200) {
      model.message!.showSnackbar(context);
    }

    // check user for attendence
    if (Globals.getUserData()!.data!.departmentId == "60f75d6885af0530888ff185" ||
        Globals.userData!.data!.departmentId == "1")
    {
      justDialog(model);
    } else if (Globals.getUserData()!.data!.departmentId == "4")
    {
      showTransferScreen(model, qrdata);
    }
    // else
    //   if (Globals.getUserData()!.data!.departmentId == "10" ||
    //     Globals.userData!.data!.departmentId == "1") {
    //   showCulvertScreen(model, qrdata);
    // }
  }

  int flexleft = 3;
  int flexright = 5;
  TextStyle style = TextStyle(
    fontSize: 16,
  );

  // show vehicles dashboard
  showSuccessDialog(QrDataModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (context, StateSetter setState1) {
              return Container(
                width: 360.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: ListView(
                    shrinkWrap: true,

                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Vehicle Details",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Vehicle Type", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.vechileType!.trim()}",
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Vehicle Number", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.vechileNo!.trim()}",
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Driver Name", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.driverName}",
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Driver Phno", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.driverNo}",
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Landmark", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.landmark}",
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Ward", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.ward}",
                              style: style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Circle", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.circle}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Scan Date", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.createdDate}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Zone", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.zone}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () async {
                          vehicle_image = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => CameraPicture()));
                          setState1(() {});
                        },
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: vehicle_image == null
                                  ? Colors.black
                                  : Colors.green[500],
                            ),
                          ),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            onSubmit = true;
                          });
                          if (vehicle_image == null) {
                            "Please add Image".showSnackbar(context);
                            return;
                          }
                          final provider = Provider.of<DashBoardProvider>(
                              context,
                              listen: false);
                          ApiResponse? response =
                              await provider.uploadVehicleImage(
                            vehicle_image: vehicle_image,
                            geoId: model.data!.geoId,
                          );
                          if (response!.status == 200) {
                            vehicle_image = null;
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: BorderRadius.circular(30)),
                            // Make rounded corner
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // step 2.1 qr
  justDialog(
    ApiResponse? model,
  ) {
    if (model!.status == 200)
      model.message != 'No results found'
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ScanDataScreen(
                  model: QrDataModel.fromJson(model.completeResponse ?? ""),
                ),
              ),
            )
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoResultFoundScreen()));
    // showSuccessDialog(QrDataModel.fromJson(model.completeResponse ?? ""));
    setState(() {});
  }

  // step 2.2 qr
  showTransferScreen(ApiResponse? model, String qrdata) {
    if (model!.status == 200)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => TransferStation(
            model: QrDataModel.fromJson(model.completeResponse ?? ""),
            scanid: qrdata,
          ),
        ),
      );
  }

// void scrhowCulvertSeen(ApiResponse model, String qrdata) {
//   if (model.status == 200)
//     CulvertScreen(CulvertIssue.fromJson(model.completeResponse))
//         .push(context);
// }
}
// todo add validation for jpg and png
