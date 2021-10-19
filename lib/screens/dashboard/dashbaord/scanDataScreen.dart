import 'dart:io' show File, Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/culvert/culvert_issue.dart';
import 'package:ghmc/model/culvert/culvert_issue_name.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/util/utils.dart';
import 'package:ghmc/widget/container/camera_gallery_container.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../dashBordScreen.dart';

class ScanDataScreen extends StatefulWidget {
  QrDataModel? model;

  ScanDataScreen({Key? key, this.model}) : super(key: key);

  @override
  _ScanDataScreenState createState() => _ScanDataScreenState(model: model);
}

class _ScanDataScreenState extends State<ScanDataScreen> {
  QrDataModel? model;

  _ScanDataScreenState({this.model});

  double fontSize = 14.0;

  int flexleft = 3;
  int flexright = 5;
  TextStyle style = TextStyle(
    fontSize: 16,
  );
  File? _image;
  CulvertIssueName? culvertIssueName;
  CulvertIssueNameItem? culvertIssueNameItem;

  List<String> issueType = ['Green', 'Orange', 'Red'];

  String? issueTypeValue;

  List<String> depth = [];

  String? depthValue;

  bool onSubmit = false;

  @override
  void initState() {
    if (model!.data!.scanType != 'vehicle')
    {
      depth = List<String>.generate(
          int.parse('${model!.data!.depth}'), (i) => '${i + 1}');
      Future.wait([_getIssueName()]);
    }
    super.initState();
  }

  Future<void> _getIssueName() async {
    final provider = Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? response = await provider.getCulvertIssuesTypes();
    culvertIssueName = CulvertIssueName.fromJson(response!.completeResponse);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: 'Scanner Data'),
      body: model!.message != 'No results found'
          ? _buildBody(context)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (model!.data!.scanType == 'vehicle') {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * double.infinity,
          width: MediaQuery.of(context).size.width * 0.90,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _sizeBox(context),
                Center(
                  child: Text(
                    "Vehicle Details",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800]),
                  ),
                ),
                _sizeBox(context),
                _rowContent(
                  'Vehicle Type',
                  '${model!.data!.vechileType ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Vehicle Number',
                  '${model!.data!.vechileNo ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Driver Name',
                  '${model!.data!.driverName ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Driver Phone',
                  '${model!.data!.driverNo ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Landmark',
                  '${model!.data!.landmark ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Ward',
                  '${model!.data!.ward ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Circle',
                  '${model!.data!.circle ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Scan Date',
                  '${model!.data!.createdDate ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Zone',
                  '${model!.data!.zone ?? ""}',
                ),
                _sizeBox(context),
                CameraGalleryContainerWidget(
                  oncapture: (file) {
                    _image = file;
                  },
                ),
                _sizeBox(context),
                TextButton(
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
                  onPressed: () async {
                    if (_image == null) {
                      "Please add Image".showSnackbar(context);
                      return;
                    }
                    MProgressIndicator.show(context);
                    GeoHolder? data = await GeoUtils().getGeoDatafromLocation(
                        await CustomLocation().getLocation(), context);

                    final provider =
                        Provider.of<DashBoardProvider>(context, listen: false);
                    ApiResponse? response = await provider.uploadVehicleImage(
                      vehicle_image: _image,
                      geoId: model!.data!.geoId,
                      address:
                          '${data!.fulldata!.results!.first.formattedAddress}',
                      longitude:
                          '${data.fulldata!.results!.first.geometry!.location!.lng}',
                      latitude:
                          '${data.fulldata!.results!.first.geometry!.location!.lat}',
                    );
                    if (response!.status == 200) {
                      _image = null;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashBoardScreen(),
                        ),
                      );
                    }
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: SvgPicture.asset(
                          'assets/check.svg',
                          width: 50,
                        ),
                        content: Text(
                          '${response.message}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
                _sizeBox(context),
              ],
            ),
          ),
        ),
      );
    } else
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * double.infinity,
          width: MediaQuery.of(context).size.width * 0.90,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                _sizeBox(context),
                Center(
                  child: Text(
                    "Culvert Details",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800]),
                  ),
                ),
                _sizeBox(context),
                _rowContent(
                  'Culvert Type',
                  '${model!.data!.culvertType ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Culvert Name',
                  '${model!.data!.culvertName ?? ""}',
                ),
                _sizeBox(context),
                culvertIssueName != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: DropdownButton(
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              hint: Text('Issue Name'),
                              isExpanded: true,
                              value: culvertIssueNameItem,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              items: culvertIssueName!.data!
                                  .map<DropdownMenuItem<CulvertIssueNameItem>>(
                                      (CulvertIssueNameItem value) {
                                return DropdownMenuItem<CulvertIssueNameItem>(
                                  value: value,
                                  child: Text("${value.name}"),
                                );
                              }).toList(),
                              onChanged: (newValue) async {
                                setState(() {
                                  culvertIssueNameItem =
                                      newValue as CulvertIssueNameItem;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                _sizeBox(context),
                Row(
                  children: [
                    Expanded(
                      flex: flexleft,
                      child: Text(
                        'Culvert depth',
                        style: style,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                      child: Text(":"),
                    ),
                    Expanded(
                      flex: flexright,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model!.data!.depth ?? ""}',
                            style: style,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child: DropdownButton(
                                  underline: Container(
                                    color: Colors.transparent,
                                  ),
                                  hint: Text('Depth'),
                                  isExpanded: true,
                                  value: depthValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  items: depth.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        depthValue = newValue!;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _sizeBox(context),
                _rowContent(
                  'Area/Colony',
                  '${model!.data!.area ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Ward',
                  '${model!.data!.ward ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Circle',
                  '${model!.data!.circle ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Zone',
                  '${model!.data!.zone ?? ""}',
                ),
                _sizeBox(context),
                _rowContent(
                  'Landmark',
                  '${model!.data!.landmark ?? ""}',
                ),
                _sizeBox(context),
                CameraGalleryContainerWidget(
                  oncapture: (file) {
                    _image = file;
                  },
                ),
                _sizeBox(context),
                TextButton(
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
                  onPressed: () async {
                    if (_image == null) {
                      "Please add photograph".showSnackbar(context);
                      return;
                    }
                    if (culvertIssueNameItem == null) {
                      "Please add Issue Name".showSnackbar(context);
                      return;
                    }
                    if (depthValue == null) {
                      "Please add depth".showSnackbar(context);
                      return;
                    }
                    MProgressIndicator.show(context);
                    final provider =
                        Provider.of<CulvertProvider>(context, listen: false);
                    ApiResponse resp = await provider.submit(
                      depth: depthValue,
                      model: model,
                      photo: _image,
                      culvertIssueName: culvertIssueNameItem,
                    );

                    if (resp.status == 200) {
                      SingleButtonDialog(
                        okbtntext: "Done",
                        onOk: (c) {
                          DashBoardScreen().pushAndPopTillFirst(context);
                        },
                        imageurl: "assets/check.svg",
                        type: Imagetype.svg,
                        message: resp.message,
                        onCancel: (c) {
                          Navigator.of(c).pop();
                          DashBoardScreen().pushAndPopTillFirst(context);
                        },
                      ).pushDialog(context);
                    }
                    if (resp.status != 200) {
                      resp.message!.showSnackbar(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _sizeBox(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }

  Widget _rowContent(String? key, String value) {
    return Row(
      children: [
        Expanded(flex: flexleft, child: Text(key!, style: style)),
        SizedBox(
          width: 15,
          child: Text(":"),
        ),
        Expanded(
            flex: flexright,
            child: Text(
              value,
              style: style,
            ))
      ],
    );
  }
}
