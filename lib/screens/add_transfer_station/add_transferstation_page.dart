import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/model/add_vehicle_model/transfer_station_model.dart';
import 'package:ghmc/model/google_maps_model.dart';
import 'package:ghmc/provider/add_data/add_data_provider.dart';
import 'package:ghmc/provider/add_vehicle/add_vehicle.dart';
import 'package:ghmc/screens/gvp_bep/googleMapScreen.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

class AddTransferStation extends StatefulWidget {
  const AddTransferStation({Key? key}) : super(key: key);

  @override
  _AddTransferStationState createState() => _AddTransferStationState();
}

class _AddTransferStationState extends State<AddTransferStation> {
  File? photo;
  bool islocationgrab = false;
  LocationData? location;

  TransferStationModel? transferStations;

  TransferTypeDataItem? selected_transferStation;

  @override
  void initState() {
    super.initState();
    loadIntialData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFAD1457),
                  Color(0xFFAD801D9E),
                ]),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Add Transfer Station"),
      ),
      body: Consumer<AddDataProvider>(builder: (context, value, child) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: DropdownButton<TransferTypeDataItem>(
                      onChanged: (val) {
                        this.selected_transferStation =
                            val as TransferTypeDataItem?;
                        setState(() {});
                      },
                      // validation to check not null
                      items: this.transferStations == null
                          ? []
                          : this
                              .transferStations!
                              .data!
                              .map(
                                  (e) => DropdownMenuItem<TransferTypeDataItem>(
                                        value: e,
                                        child: Text("${e.name}"),
                                      ))
                              .toList(),
                      isExpanded: true,
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 40,
                      ),
                      hint: Center(
                        child: Text(
                          this.selected_transferStation == null
                              ? " Transfer Station List"
                              : "${this.selected_transferStation!.name}",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                height: 250,
                width: 340,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            this.islocationgrab ? Colors.green : Colors.black,
                        onPressed: () async {
                          await GoogleMapScreen().push(context);

                          CustomLocation customlocation = new CustomLocation();
                          location = await customlocation.getLocation();
                          setState(() {
                            if (location != null &&
                                (location!.latitude!.isNaN == false))
                              this.islocationgrab = true;
                          });
                        },
                        child: Image.asset(
                          "assets/images/location.png",
                          color: Colors.white,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (location != null)
                        Text(
                            "📌 Longitude:${this.location!.longitude}\n\n📌 Latitude: ${this.location!.latitude}")
                    ],
                  ),
                ),
              ),
            ),
            this.photo == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: 340,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Center(
                        child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () async {
                              // photo = await FilePick().takecameraPic();
                              // setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CameraCamera(
                                      resolutionPreset: ResolutionPreset.low,
                                      onFile: (file) async {
                                        "Photo taken".printinfo;
                                        setState(() {
                                          photo = File(file.path);
                                        });
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                    ),
                                  ));
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 40,
                            )),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: 340,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Image.file(this.photo!)),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: FlatButton(
                  height: 40,
                  minWidth: 320,
                  onPressed: () async {
                    if (this.selected_transferStation == null) {
                      "Please select transfer station".showSnackbar(context);
                      return;
                    } else if (this.location == null ||
                        this.location!.latitude == null) {
                      "Please grab location first".showSnackbar(context);
                      return;
                    } else if (this.photo == null) {
                      "Please click the photo".showSnackbar(context);
                      return;
                    }
                    MProgressIndicator.show(context);
                    ApiResponse response = await value.uploadTransferStation(
                        context,
                        this.selected_transferStation,
                        this.location,
                        this.photo);
                    MProgressIndicator.hide();

                    await SingleButtonDialog(
                      message: response.message,
                      onOk: (context) {
                        Navigator.of(context).pop();
                        // DashBoardScreen().pushAndPopTillFirst(context);
                      },
                      imageurl: "assets/svgs/garbage-truck.svg",
                    ).pushDialog(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
            ),
          ],
        );
      }),
    );
  }

  void loadIntialData() async {
    TransferStationModel? model =
        await Provider.of<AddVehicleProvider>(context, listen: false)
            .getTransferStation();
    if (model == null) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        "Unable to load TransferStations".showSnackbar(context);
      });
      return;
    } else {
      this.transferStations = model;
    }
    setState(() {});
  }
}
