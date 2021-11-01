import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/all_drop_down_model.dart';

import 'package:ghmc/model/culvert/area_model.dart';
import 'package:ghmc/provider/community_hall/community_hall.dart';
import 'package:ghmc/provider/complex_building/complex_building.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/provider/open_place/open_place.dart';
import 'package:ghmc/provider/temple/temple.dart';
import 'package:ghmc/util/extension.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/container/camera_container.dart';
import 'package:ghmc/widget/container/map_container.dart';
import 'package:ghmc/widget/grid/grid_image.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:provider/provider.dart';

import 'package:ghmc/util/utils.dart';

@immutable
class TempleScreen extends StatefulWidget {
  TempleScreen({Key? key}) : super(key: key);

  @override
  _TempleScreenState createState() => _TempleScreenState();
}

class _TempleScreenState extends State<TempleScreen> {
  CulvertDataModel? zones;
  CulvertDataModel? circles;
  CulvertDataModel? wards;
  CulvertDataModel? areas;
  CulvertDataModel? landmarks;

  DataItem? _selected_zones;
  DataItem? _selected_circle;
  DataItem? _selected_ward;
  DataItem? _selected_area;
  DataItem? _selected_landmarks;

  var landmark = TextEditingController();
  var name = TextEditingController();
  var address = TextEditingController();
  var floors = TextEditingController();
  String? _selectedbasement;
  String? _selectedGroundFloor;

  LocationData? locationData;

  List<File>? images = [];

  double fontSize = 14.0;

  Quality_waste? _select_quantity;
  TextStyle hintStyle = TextStyle(fontSize: 14);
  var Business_name = TextEditingController();

  var shop_flat_address = TextEditingController();

  var inchargeName = TextEditingController();
  var inchargeMobileNumber = TextEditingController();
  var owner_aadhaar = TextEditingController();
  Existing_disposal? _selected_disposal;

  late TempleProvider provider =
      Provider.of<TempleProvider>(context, listen: false);

  var templeName = TextEditingController();

  var wastageQty = TextEditingController();

  Type_of_details? _selectedPlace;

  @override
  void initState() {
    super.initState();
    _initialisedZones();
    provider.loadCommunityItems(context);
    provider = Provider.of<TempleProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FAppBar.getCommonAppBar(
            title: "Devotional/Govt Establishment",
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        body: Consumer<TempleProvider>(builder: (context, snapshot, child) {
          return snapshot.dropDowns != null && zones != null
              ? ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    //zones
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(
                              "Zones",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Zones'),
                                    isExpanded: true,
                                    value: _selected_zones,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
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
                                        _selected_zones = newValue as DataItem;
                                        circles = null;
                                        this.landmarks = null;
                                        this._selected_landmarks = null;
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
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(
                              "Circle",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<DataItem>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Circles'),
                                    isExpanded: true,
                                    value: _selected_circle,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: circles != null
                                        ? circles!.data!
                                            .map<DropdownMenuItem<DataItem>>(
                                                (DataItem value) {
                                            return DropdownMenuItem<DataItem>(
                                              value: value,
                                              child: Text("${value.name}"),
                                            );
                                          }).toList()
                                        : [],
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_circle = newValue as DataItem;
                                        wards = null;
                                        _selected_ward = null;
                                        areas = null;
                                        _selected_area = null;
                                        this.landmarks = null;
                                        this._selected_landmarks = null;
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
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(
                              "Ward",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<DataItem>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Wards'),
                                    isExpanded: true,
                                    value: _selected_ward,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: wards != null
                                        ? wards!.data!
                                            .map<DropdownMenuItem<DataItem>>(
                                                (DataItem value) {
                                            return DropdownMenuItem<DataItem>(
                                              value: value,
                                              child: Text("${value.name}"),
                                            );
                                          }).toList()
                                        : [],
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_ward = newValue as DataItem;
                                        areas = null;
                                        _selected_area = null;
                                        this.landmarks = null;
                                        this._selected_landmarks = null;
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
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(
                              "Areas/Colony",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<DataItem>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Areas'),
                                    isExpanded: true,
                                    value: _selected_area,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: areas != null
                                        ? areas!.data!
                                            .map<DropdownMenuItem<DataItem>>(
                                                (DataItem value) {
                                            return DropdownMenuItem<DataItem>(
                                              value: value,
                                              child: Text("${value.name}"),
                                            );
                                          }).toList()
                                        : [],
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_area = newValue as DataItem;
                                        landmarks = null;
                                        _selected_landmarks = null;
                                        this._intialised_Landmarks();

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
                    //see landmarks
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(
                              "Landmarks",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<DataItem>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Landmarks'),
                                    isExpanded: true,
                                    value: _selected_landmarks,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: landmarks != null
                                        ? landmarks!.data!
                                            .map<DropdownMenuItem<DataItem>>(
                                                (DataItem value) {
                                            return DropdownMenuItem<DataItem>(
                                              value: value,
                                              child: Text("${value.name}"),
                                            );
                                          }).toList()
                                        : [],
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_landmarks =
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
                    //see address
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Address",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: TextFormField(
                                  controller: address,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type address here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //see open place name
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Name",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: TextFormField(
                                  controller: templeName,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type Place name here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//see incharge name
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Incharge Name",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: TextFormField(
                                  controller: inchargeName,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type name here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//incharge mobile no
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Incharge Mobile Number",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: TextFormField(
                                  controller: inchargeMobileNumber,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type 10 digit number here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Existing disposal
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Existing Disposal",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<Existing_disposal>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Disposal'),
                                    isExpanded: true,
                                    value: _selected_disposal,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider
                                        .dropDowns!.data!.existingDisposal!
                                        .map<
                                                DropdownMenuItem<
                                                    Existing_disposal>>(
                                            (Existing_disposal value) {
                                      return DropdownMenuItem<
                                          Existing_disposal>(
                                        value: value,
                                        child: Text("${value.disposal}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_disposal = newValue;
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

                    //type
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Place Type",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<Type_of_details>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Place'),
                                    isExpanded: true,
                                    value: _selectedPlace,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider
                                        .dropDowns!.data!.typeOfDetails!
                                        .map<DropdownMenuItem<Type_of_details>>(
                                            (Type_of_details value) {
                                      return DropdownMenuItem<Type_of_details>(
                                        value: value,
                                        child: Text("${value.name}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selectedPlace = newValue;
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

                    //quantity disposal
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Select Quantity",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<Quality_waste>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Quantity Type'),
                                    isExpanded: true,
                                    value: _select_quantity,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider
                                        .dropDowns!.data!.qualityWaste!
                                        .map<DropdownMenuItem<Quality_waste>>(
                                            (Quality_waste value) {
                                      return DropdownMenuItem<Quality_waste>(
                                        value: value,
                                        child: Text("${value.waste}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _select_quantity = newValue;
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
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Wastage Quantity ",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: TextFormField(
                                  controller: wastageQty,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type Wastage Quantity "),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // camera container
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MapContainer(
                        locationData: (s) async {
                          locationData = s;
                        },
                      ),
                    ),
                    GridImage(  images:   this.images! ,
                      context: context,
                      title: "Select Image",
                      onchange: (List<File> files) async {
                        MProgressIndicator.show(context);
                        try {
                          List<File>? tempimages = [];
                          await Future.forEach(files, (e) async {
                            print(e);
                            File? file =
                                await FileSupport().compressImage(e as File);
                            tempimages.add(file!);
                          });
                          this.images!.clear();
                          "${tempimages.length} are compress"
                              .toString()
                              .printwtf;
                          this.images!.addAll(tempimages);
                        } catch (e) {
                          MProgressIndicator.hide();
                        }
                        MProgressIndicator.hide();
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    GradientButton(
                      title: "Submit",
                      onclick: () async {
                        if (this.locationData == null) {
                          "Please choose location first".showSnackbar(context);
                          return;
                        }

                        if (this.images!.length > 5) {
                          "Only max 5 images are allowed".showSnackbar(context);
                          return;
                        }
                        FormData formData = FormData.fromMap({
                          'user_id': Globals.userData?.data?.userId ?? "",
                          'zones_id': _selected_zones?.id ?? "",
                          'circles_id': _selected_circle?.id ?? "",
                          'area_id': _selected_area?.id ?? "",
                          'ward_id': _selected_ward?.id ?? "",
                          'landmark_id': _selected_landmarks?.id ?? "",
                          'address': address.text,
                          'temple_name': templeName.text,
                          'incharge_name': inchargeName.text,
                          'incharge_mobile': inchargeMobileNumber.text,
                          'existing_disposal':
                              _selected_disposal?.disposal ?? "",
                          'quality_of_waste': _select_quantity?.waste ?? "",
                          'wastage_quantity': wastageQty.text,
                          'type': _selectedPlace?.name ?? "",
                          'latitude':
                              (this.locationData?.latitude)?.toString() ?? "",
                          'longitude':
                              (this.locationData?.latitude)?.toString() ?? "",
                          'images': [
                            for (var file in this.images!)
                              ...{
                                await MultipartFile.fromFile(file.path,
                                    filename: file.path.split('/').last)
                              }.toList()
                          ]
                        });

                        MProgressIndicator.show(context);
                        ApiResponse res =
                            await provider.createTemple(formData, context);
                        MProgressIndicator.hide();
                        print(res.status);
                        if (res.status == 200) {
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                )
              : Loading();
        }));
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
    MProgressIndicator.show(context);
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? resp = await culvert_provider.getCircles(_selected_zones!);
    MProgressIndicator.hide();
    if (resp!.status == 200)
      circles = CulvertDataModel.fromJson(resp.completeResponse);
    else
      resp.message!.showSnackbar(context);

    setState(() {});
  }

  // get data for wards
  Future<void> _intialised_Wards() async {
    MProgressIndicator.show(context);
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

  void _intialised_Landmarks() async {
    MProgressIndicator.show(context);
    final culvert_provider =
        Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? resp = await culvert_provider.getLandmarks(_selected_area!);
    if (resp!.status == 200)
      landmarks = CulvertDataModel.fromJson(resp.completeResponse);
    else
      resp.message!.showSnackbar(context);
    setState(() {});
  }

  _intialBuisnessType() {}
}
