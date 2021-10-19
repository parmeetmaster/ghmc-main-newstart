import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/culvert/area_model.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/container/map_container.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

class AddCulvertScreen extends StatefulWidget {
  const AddCulvertScreen({Key? key}) : super(key: key);

  @override
  _AddCulvertScreenState createState() => _AddCulvertScreenState();
}

class _AddCulvertScreenState extends State<AddCulvertScreen> {
  List<String> areaColony = ['areaColony'];

  String? areaColonyValue;

  List<String> circle = ['circle'];

  String? circleValue;

  //List<String> ward = ['ward'];

  List<String> culvertType = ['Major', 'Minor'];

  String? culvertTypeValue;

  List<String> depth = [];

  String? depthValue;

  double fontSize = 14.0;

  CulvertDataModel? zones;
  CulvertDataModel? circles;
  CulvertDataModel? wards;
  CulvertDataModel? areas;

  DataItem? _selected_zones;
  DataItem? _selected_circle;
  DataItem? _selected_ward;
  DataItem? _selected_area;

  TextEditingController landmark = new TextEditingController();
  TextEditingController culvert_name = new TextEditingController();
  LocationData? locationData;

  @override
  void initState() {
    depth = List<String>.generate(20, (i) => '${i + 1}');
    super.initState();

    Future.wait([_initialisedZones()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Add Culvert"),
      body: (zones != null)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          //zones
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Zones",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 0),
                                        child: DropdownButton(
                                          underline: Container(
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Zones'),
                                          isExpanded: true,
                                          value: _selected_zones,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: zones!.data!
                                              .map<DropdownMenuItem<DataItem>>(
                                                  (DataItem value) {
                                            return DropdownMenuItem<DataItem>(
                                              value: value,
                                              child: Text("${value.name}"),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) async {
                                            setState(() {
                                              _selected_zones =
                                                  newValue as DataItem;
                                              circles = null;
                                              _selected_circle = null;
                                              wards = null;
                                              _selected_ward = null;
                                              areas = null;
                                              _selected_area = null;
                                              _intialised_Circles();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // see circle
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Circle",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 0),
                                        child: DropdownButton<DataItem>(
                                          underline: Container(
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Circles'),
                                          isExpanded: true,
                                          value: _selected_circle,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: circles != null
                                              ? circles!.data!.map<
                                                      DropdownMenuItem<
                                                          DataItem>>(
                                                  (DataItem value) {
                                                  return DropdownMenuItem<
                                                      DataItem>(
                                                    value: value,
                                                    child:
                                                        Text("${value.name}"),
                                                  );
                                                }).toList()
                                              : [],
                                          onChanged: (newValue) async {
                                            setState(() {
                                              _selected_circle =
                                                  newValue as DataItem;
                                              wards = null;
                                              _selected_ward = null;
                                              areas = null;
                                              _selected_area = null;
                                              _intialised_Wards();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // see ward
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Ward",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 0),
                                        child: DropdownButton<DataItem>(
                                          underline: Container(
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Wards'),
                                          isExpanded: true,
                                          value: _selected_ward,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: wards != null
                                              ? wards!.data!.map<
                                                      DropdownMenuItem<
                                                          DataItem>>(
                                                  (DataItem value) {
                                                  return DropdownMenuItem<
                                                      DataItem>(
                                                    value: value,
                                                    child:
                                                        Text("${value.name}"),
                                                  );
                                                }).toList()
                                              : [],
                                          onChanged: (newValue) async {
                                            setState(() {
                                              _selected_ward =
                                                  newValue as DataItem;
                                              areas = null;
                                              _selected_area = null;
                                              _intialised_Areas();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //see areas
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Areas/Colony",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 0),
                                        child: DropdownButton<DataItem>(
                                          underline: Container(
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Areas'),
                                          isExpanded: true,
                                          value: _selected_area,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: areas != null
                                              ? areas!.data!.map<
                                                      DropdownMenuItem<
                                                          DataItem>>(
                                                  (DataItem value) {
                                                  return DropdownMenuItem<
                                                      DataItem>(
                                                    value: value,
                                                    child:
                                                        Text("${value.name}"),
                                                  );
                                                }).toList()
                                              : [],
                                          onChanged: (newValue) async {
                                            setState(() {
                                              _selected_area =
                                                  newValue as DataItem;
                                              setState(() {});
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Landmark",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: TextFormField(
                                        controller: landmark,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 11,
                                                right: 15),
                                            hintText: "Type Landmark here..."),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Culvert Name",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                        child: TextFormField(
                                          controller: culvert_name,
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15,
                                                  bottom: 11,
                                                  top: 11,
                                                  right: 15),
                                              hintText:
                                                  "Type culvert name here..."),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Culvert Type",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 0),
                                        child: DropdownButton(
                                          underline: Container(
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Culvert Type'),
                                          isExpanded: true,
                                          value: culvertTypeValue,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: culvertType
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(
                                              () {
                                                culvertTypeValue = newValue!;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    "Depth",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 0),
                                        child: DropdownButton(
                                          underline: Container(
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Depth'),
                                          isExpanded: true,
                                          value: depthValue,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: depth
                                              .map<DropdownMenuItem<String>>(
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MapContainer(
                      locationData: (s) async {
                        locationData = s;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextButton(
                        onPressed: () {
                          _submit();
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
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  // get data for zones
  Future<void> _initialisedZones() async {
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? resp = await culvert_provider.getZones();
    if (resp!.status == 200)
      zones = CulvertDataModel.fromJson(resp.completeResponse);
    else
      resp.message!.showSnackbar(context);

    setState(() {});
  }

  // get data for wards
  Future<void> _intialised_Circles() async {
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? resp = await culvert_provider.getCircles(_selected_zones!);
    if (resp!.status == 200)
      circles = CulvertDataModel.fromJson(resp.completeResponse);
    else
      resp.message!.showSnackbar(context);

    setState(() {});
  }

  // get data for wards
  Future<void> _intialised_Wards() async {
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? resp = await culvert_provider.getWards(_selected_circle);
    if (resp!.status == 200)
      wards = CulvertDataModel.fromJson(resp.completeResponse);
    else
      resp.message!.showSnackbar(context);

    setState(() {});
  }

  void _intialised_Areas() async {
    MProgressIndicator.show(context);
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? resp = await culvert_provider.getAreas(_selected_ward!);
    if (resp!.status == 200)
      areas = CulvertDataModel.fromJson(resp.completeResponse);
    else
      resp.message!.showSnackbar(context);
    setState(() {});
  }

  void _submit() async {
    if (landmark.text.isEmpty) {
      "Please add Landmark".showSnackbar(context);
      return;
    }

    if (_selected_ward == null) {
      "Please Select Ward".showSnackbar(context);
      return;
    }

    if (_selected_area == null) {
      "Please Select Area".showSnackbar(context);
      return;
    }

    if (culvertTypeValue == null) {
      "Please Select Culvert Type".showSnackbar(context);
      return;
    }

    if (depthValue == null) {
      "Please Select Depth".showSnackbar(context);
      return;
    }

    if (culvert_name.text.isEmpty) {
      "Please add Culvert Name".showSnackbar(context);
      return;
    }

    if (landmark.text.isEmpty) {
      "Please add Landmark".showSnackbar(context);
      return;
    }

    if (locationData == null) {
      "Please add Location".showSnackbar(context);
      return;
    }
    if (locationData == null) {
      "Please add Depth".showSnackbar(context);
      return;
    }
    MProgressIndicator.show(context);
    GeoHolder? data = await GeoUtils()
        .getGeoDatafromLocation(await CustomLocation().getLocation(), context);
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse resp = await culvert_provider.add_culvert(
      ward: _selected_ward!.id!,
      area: _selected_area!.id!,
      landmark: landmark.text,
      culvert_name: culvert_name.text,
      culvertType: culvertTypeValue!,
      depth: depthValue!,
      location_format_address: data!.statename!,
      location: locationData,
    );

    if (resp.status == 200) {
      SingleButtonDialog(
        message: resp.message,
        imageurl: "assets/check.svg",
        type: Imagetype.svg,
        onOk: (c) {
          DashBoardScreen().pushAndPopTillFirst(context);
        },
      ).pushDialog(context);
    } else {
      resp.message!.showSnackbar(context);
    }
  }
}
