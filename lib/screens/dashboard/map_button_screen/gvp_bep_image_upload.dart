import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/dashboard/app_bar/dashboard_location_gep_bep_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/card_seperate_row.dart';
import 'package:ghmc/widget/container/camera_gallery_container.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

import '../dashBordScreen.dart';

class GvpBepImageUpload extends StatefulWidget {
  const GvpBepImageUpload({Key? key}) : super(key: key);

  @override
  _GvpBepImageUploadState createState() => _GvpBepImageUploadState();
}

class _GvpBepImageUploadState extends State<GvpBepImageUpload> {
  DashboardLocationGepBepModel? _model;

  @override
  void initState() {
    super.initState();
    loadIntialData();
  }

  File? _before_image;
  File? _after_image;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashBoardProvider>(context);
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Gvp/BEP MAP"),
      body: _model != null && _model!.found == true
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CardSeperateRow("Type", _model?.data?.type ?? ""),
                        CardSeperateRow("Area", _model?.data?.area ?? ""),
                        CardSeperateRow(
                            "LandMark", _model?.data?.landmark ?? ""),
                        CardSeperateRow("Ward", _model?.data?.ward ?? ""),
                        CardSeperateRow("Circle", _model?.data?.circle ?? ""),
                        CardSeperateRow("Zone", _model?.data?.zone ?? ""),
                        //  CardSeperateRow("City",""),
                      ],
                    ),
                  ),
                ),
                // 1️⃣
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Before Image",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                CameraGalleryContainerWidget(
                  oncapture: (file) {
                    _before_image = file;
                  },
                ),

                // 2️⃣
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "After Image",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                CameraGalleryContainerWidget(
                  oncapture: (file) {
                    _after_image = file;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GradientButton(
                    onclick: () async {
                      ApiResponse resp;

                      if (_before_image != null && _after_image != null) {
                        resp = await provider.submitGepBep(
                            _before_image, _after_image, _model);

                        if (resp.status == 200) {
                          SingleButtonDialog(
                            message: resp.message,
                            onOk: (c) {
                              DashBoardScreen().pushAndPopTillFirst(context);
                            },
                            type: Imagetype.svg,
                            imageurl: "assets/check.svg",
                          ).pushDialog(context);
                        } else {
                          resp.message!.showSnackbar(context);
                        }
                      } else {
                        "Please add Images".showSnackbar(context);
                      }
                    },
                    title: "Submit",
                    fontsize: 18,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            )
          : Container(
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }

  void loadIntialData() async {
    final provider = DashBoardProvider.getReference(context);
    ApiResponse response = await provider.getGepDataWithLocation();
    _model = DashboardLocationGepBepModel.fromJson(response.completeResponse);
    setState(() {});
  }
}
