import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/dashboard/app_bar/dashboard_location_gep_bep_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/card_seperate_row.dart';
import 'package:ghmc/widget/container/camera_gallery_container.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

import '../dashBordScreen.dart';

class GvpBepMap extends StatefulWidget {
  const GvpBepMap({Key? key}) : super(key: key);

  @override
  _GvpBepMapState createState() => _GvpBepMapState();
}

class _GvpBepMapState extends State<GvpBepMap> {
  DashboardLocationGepBepModel? _model;

  @override
  void initState() {
    super.initState();
    Future.wait([_loadIntialData()]);
  }

  File? _before_image;
  File? _after_image;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashBoardProvider>(context);
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "GVP/BEP MAP"),
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
                        _itemKeyValue(
                            context, "Type", _model?.data?.type ?? ""),
                        _itemKeyValue(
                            context, "Area", _model?.data?.area ?? ""),
                        _itemKeyValue(
                            context, "LandMark", _model?.data?.landmark ?? ""),
                        _itemKeyValue(
                            context, "Ward", _model?.data?.ward ?? ""),
                        _itemKeyValue(
                            context, "Circle", _model?.data?.circle ?? ""),
                        _itemKeyValue(
                            context, "Zone", _model?.data?.zone ?? ""),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: GradientButton(
                      onclick: () async {
                        ApiResponse resp;

                        if (_before_image != null && _after_image != null) {
                          MProgressIndicator.show(context);
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

  Widget _itemKeyValue(
    BuildContext context,
    String? key,
    String? value,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "${key}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          width: 15,
          child: Text(":", style: TextStyle(fontSize: 22)),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "${value ?? ""}",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Future<void> _loadIntialData() async {
    final provider = DashBoardProvider.getReference(context);
    ApiResponse response = await provider.getGepDataWithLocation();
    if (response.status == 200)
      _model = DashboardLocationGepBepModel.fromJson(response.completeResponse);
    else
      response.message!.showSnackbar(context);

    setState(() {});
  }

// void loadIntialData() async {
//   final provider = DashBoardProvider.getReference(context);
//   ApiResponse response = await provider.getGepDataWithLocation();
//   _model = DashboardLocationGepBepModel.fromJson(response.completeResponse);
//   setState(() {});
// }
}
