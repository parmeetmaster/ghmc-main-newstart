import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'dart:io';
import 'package:ghmc/util/utils.dart';
import 'package:dio/dio.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/container/camera_gallery_container.dart';
import 'package:ghmc/widget/drawer.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class TransferStation extends StatefulWidget {
  QrDataModel? model;
  String? scanid;

  TransferStation({QrDataModel? model, String? scanid, Key? key}) {
    this.model = model;
    this.scanid = scanid;
  }

  @override
  _TransferStationState createState() => _TransferStationState();
}

class _TransferStationState extends State<TransferStation> {
  double gap = 10;
  int? active_percent = 25;
  File? capture_image = null;
  int? type_of_waste = 0;
  bool isdomestic = true;
  bool iscommercial = false;

  late Future<MultipartFile>? multipart;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: MainDrawer(),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFFAD1457),
                Color(0xFFAD801D9E),
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'menu',
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(
            '${Globals.userData!.data!.firstName ?? ""} ${Globals.userData!.data!.lastName ?? ""}'),
        actions: [
          Image.asset("assets/truck.png"),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Scan',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashBoardScreen(
                            operaton: WhatToDo.qrscan,
                          )),
                  (route) => false);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      _getRowVehicleDetails(
                          key: "Owner Type",
                          value: "${widget.model!.data!.owner_type}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Vehicle Type",
                          value: "${widget.model!.data!.vechileType}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Vehicle Number",
                          value: "${widget.model!.data!.vechileNo}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Drive Name",
                          value: "${widget.model!.data!.driverName}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Driver Number",
                          value: "${widget.model!.data!.driverNo}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Landmark",
                          value: "${widget.model!.data!.landmark}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Ward", value: "${widget.model!.data!.ward}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Circle",
                          value: "${widget.model!.data!.circle}"),
                      SizedBox(
                        height: gap,
                      ),
                      _getRowVehicleDetails(
                          key: "Zone", value: "${widget.model!.data!.zone}"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .06,
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFAD1457),
                        Color(0xFFAD801D9E),
                      ]),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Center(
                child: Text(
                  "Type of Waste",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getPercentageContainer("25"),
              _getPercentageContainer("50"),
              _getPercentageContainer("75"),
              _getPercentageContainer("100"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .06,
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFAD1457),
                        Color(0xFFAD801D9E),
                      ]),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Center(
                child: Text(
                  "Percentage Of Waste",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    this.isdomestic = !this.isdomestic;
                    setState(() {});
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 10),
                    decoration: BoxDecoration(
                        color: this.isdomestic == true
                            ? Colors.pink
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2,
                            color: this.isdomestic == true
                                ? Color(0xFF5FD548)
                                : Color(0xFF9C27B0))),
                    child: Center(
                      child: Text(
                        "Domestic",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: this.isdomestic == true
                                ? Colors.white
                                : Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    this.iscommercial = !iscommercial;
                    setState(() {});
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 10),
                    decoration: BoxDecoration(
                        color: this.iscommercial == true
                            ? Colors.pink
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2,
                            color: this.iscommercial == true
                                ? Color(0xFF5FD548)
                                : Color(0xFF9C27B0))),
                    child: Center(
                      child: Text(
                        "Commercial",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: this.iscommercial == true
                                ? Colors.white
                                : Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      child: Center(
                          child: Text(
                        "Live Picture",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFAD1457),
                            Color(0xFFAD801D9E),
                          ],
                        ),
                      ),
                      height: 50,
                      width: 99,
                    ),
                  ),
                  CameraGalleryContainerWidget(
                    oncapture: (file) {
                      capture_image = file;
                    },
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     this.multipart = getMultiPartFromFile();
                  //   },
                  //   child: capture_image == null
                  //       ? Container(
                  //           child: Center(
                  //             child: Icon(
                  //               Icons.camera_alt_outlined,
                  //               size: 70,
                  //             ),
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.5),
                  //                 spreadRadius: 5,
                  //                 blurRadius: 7,
                  //                 offset: Offset(
                  //                     0, 3), // changes position of shadow
                  //               ),
                  //             ],
                  //           ),
                  //           height: 200,
                  //           width: 99,
                  //         )
                  //       : Container(
                  //           child: Center(
                  //             child: Image.file(
                  //               capture_image!,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.5),
                  //                 spreadRadius: 5,
                  //                 blurRadius: 7,
                  //                 offset: Offset(
                  //                     0, 3), // changes position of shadow
                  //               ),
                  //             ],
                  //           ),
                  //           height: 200,
                  //           width: 99,
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (this.capture_image == null) {
                "No image Selected".showSnackbar(context);
                return;
              }
              if (this.isdomestic == true) {
                this.type_of_waste = 0;
              } else if (this.iscommercial == true) {
                this.type_of_waste = 1;
              } else if (this.isdomestic == true && this.iscommercial == true) {
                this.type_of_waste = 2;
              }
              MProgressIndicator.show(context);

              await DashBoardProvider.getReference(context).uploadData(
                active_percent,
                type_of_waste,
                widget.model,
                widget.scanid,
                capture_image,
                context,
              );
              // remove images so user need to capture new image on upload
              this.capture_image = null;
              this.multipart = null;
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .2),
              child: Container(
                width: 200,
                child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }

// widgets
  _getRowVehicleDetails({String key = "", String value = ""}) {
    int flexleft = 4;
    int flexright = 5;
    TextStyle style = TextStyle(
      fontSize: 16,
    );
    return Row(
      children: [
        Expanded(flex: flexleft, child: Text("$key", style: style)),
        SizedBox(
          width: 15,
          child: Text(":"),
        ),
        Expanded(
            flex: flexright,
            child: Text(
              "$value",
              style: style,
            ))
      ],
    );
  }

  _getPercentageContainer(String percent) {
    return InkWell(
      onTap: () {
        this.active_percent = int.parse(percent);
        setState(() {});
      },
      child: Container(
        height: 40,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            percent + "%",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: int.parse(percent) == active_percent
                ? [
                    Color(0xFF297F29),
                    Color(0xFF5FD548),
                    Color(0xFF5BFF69),
                  ]
                : [
                    Color(0xFFAD1457),
                    Color(0xFFAD801D9E),
                  ],
          ),
        ),
      ),
    );
  }

  void _truck_loader() {}

  Future<MultipartFile> getMultiPartFromFile() async {
    File? file = await pickImage();
    MultipartFile pic = await MultipartFile.fromFile(file!.path,
        filename: file.path.split("/").last,
        contentType: MediaType.parse("image/${file.path.split(".").last}"));
    return pic;
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    final File? file = File(pickedFile!.path);
    this.capture_image = file;
    setState(() {});
    return file;
  }
}
