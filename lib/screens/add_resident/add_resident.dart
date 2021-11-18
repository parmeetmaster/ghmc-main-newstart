import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/all_drop_down_model.dart';
import 'package:ghmc/model/culvert/area_model.dart';
import 'package:ghmc/provider/add_resident/add_resident_provider.dart';
import 'package:ghmc/provider/community_hall/community_hall.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/screens/add_resident/search_resident.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/util/extension.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/container/map_container.dart';
import 'package:ghmc/widget/grid/grid_image.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:ghmc/widget/pagination/pagination_covid_form.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

enum RESIDENT_OPR { update, insert }

@immutable
class AddResidentScreen extends StatefulWidget {
  RESIDENT_OPR? resident_opr;
  String? uuid;

  AddResidentScreen({Key? key, this.resident_opr, this.uuid}) : super(key: key);

  @override
  _AddResidentScreenState createState() => _AddResidentScreenState();
}

class _AddResidentScreenState extends State<AddResidentScreen> {
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

  late final CommunityHallProvider communityHallProvider;

  String? _selected_floor = null;
  Category_type? _selected_category_type = null;
  Business_type? _selected_Business_type = null;
  Licence? _selected_license = null;
  Quality_waste? _select_quantity;
  Existing_disposal? _existing_disposal = null;
  TextStyle hintStyle = TextStyle(fontSize: 14);
  var Business_name = TextEditingController();

  var shop_flat_address = TextEditingController();

  var ownerName = TextEditingController();
  var owner_mobile_phno = TextEditingController();
  var eighteenabove = TextEditingController();
  var propertyNo = TextEditingController();
  Existing_disposal? _selected_disposal;

  late CommunityHallProvider provider =
  Provider.of<CommunityHallProvider>(context, listen: false);

  late ResidentProvider residentProvider =
  Provider.of<ResidentProvider>(context, listen: false);

  Type_of_house? _selected_housetype;

  var wastageQty = TextEditingController();

  int formno = 1;

  @override
  void initState() {
    super.initState();
    _initialisedZones();
    provider.loadCommunityItems(context);
    residentProvider.getUuidFromApi(context, widget.uuid);

    if (widget.resident_opr == RESIDENT_OPR.update) {
      residentProvider.getPrefillResidentDetails(context, widget.uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FAppBar.getAppBarWithSearch(
            title: "Search Resident Details",
            onclick: () {
              SearchResident().push(context);
            }),
        body: Consumer2<ResidentProvider, CommunityHallProvider>(
            builder: (context, residentSnapShot, communityHallSnapshot, child) {
              return communityHallSnapshot.dropDowns != null && zones != null
                  ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  //zones
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.18,
                          child: Text(
                            "Zones",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child: widget.resident_opr ==
                                    RESIDENT_OPR.update ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                                      child: Text(
                                      residentProvider.prefillModel?.data?.first
                                          .zoneName ?? ""),
                                    ): DropdownButton(
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.18,
                          child: Text(
                            "Circle",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child:widget.resident_opr ==
                                    RESIDENT_OPR.update ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                      residentProvider.prefillModel?.data?.first
                                          .circleName ?? ""),
                                ): DropdownButton<DataItem>(
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.18,
                          child: Text(
                            "Ward",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child:widget.resident_opr ==
                                    RESIDENT_OPR.update ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                      residentProvider.prefillModel?.data?.first
                                          .wardname ?? ""),
                                ): DropdownButton<DataItem>(
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.18,
                          child: Text(
                            "Areas/Colony",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child:widget.resident_opr ==
                                    RESIDENT_OPR.update ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                      residentProvider.prefillModel?.data?.first
                                          .areaName ?? ""),
                                ): DropdownButton<DataItem>(
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
                  //landmarks
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.18,
                          child: Text(
                            "Landmarks",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child:widget.resident_opr ==
                                    RESIDENT_OPR.update ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                      residentProvider.prefillModel?.data?.first
                                          .landmarkName ?? ""),
                                ): DropdownButton<DataItem>(
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
                  //shop flat address
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox(): Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "House Address",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: TextFormField(
                                controller: shop_flat_address,
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
                                    hintText: "Type Address here..."),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //owner name
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Owner Name",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child:widget.resident_opr ==
                                  RESIDENT_OPR.update ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 10),
                                child: Text(
                                    residentProvider.prefillModel?.data?.first
                                        .ownerName ?? ""),
                              ): TextFormField(
                                controller: ownerName,
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
//owner mobile no
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():   Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Owner Mobile Number",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: TextFormField(
                                controller: owner_mobile_phno,
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
                                    hintText: "Type 10 digit number here"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  CovidFormData(
                      controller: residentProvider.covidFormController,
                      resident_opr: widget.resident_opr,
                      uuid: widget.uuid),

//owner adhaar
                  /*   Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Owner Aadhaar Number",
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
                                  controller: owner_aadhaar,
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
                                      hintText: "Type Aadhaar here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/

/*
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(
                              "Business Type",
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
                                  child: DropdownButton<Business_type>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Business Type'),
                                    isExpanded: true,
                                    value: _selected_Business_type,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider.dropDowns!
                                        .data!.businessType!
                                        .map<DropdownMenuItem<Business_type>>(
                                            (Business_type value) {
                                      return DropdownMenuItem<Business_type>(
                                        value: value,
                                        child: Text("${value.name}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_Business_type = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  // resident type
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():      Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Resident Type",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child: DropdownButton<Type_of_house>(
                                  underline: Container(
                                    color: Colors.transparent,
                                  ),
                                  hint: Text('Select Resident'),
                                  isExpanded: true,
                                  value: _selected_housetype,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  items: provider
                                      .dropDowns!.data!.typeOfHouse!
                                      .map<DropdownMenuItem<Type_of_house>>(
                                          (Type_of_house value) {
                                        return DropdownMenuItem<Type_of_house>(
                                          value: value,
                                          child: Text("${value.type}"),
                                        );
                                      }).toList(),
                                  onChanged: (newValue) async {
                                    setState(() {
                                      _selected_housetype = newValue;
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

                  //Existing disposal
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():      Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Existing Disposal",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
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

                  //quantity disposal
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():          Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Approx Quantity of waste",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
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

                  //wastage Quantity
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():    Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Wastage Weight",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
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
                                    hintText:
                                    "Type Wastage Quantity here..."),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "18+ members",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: TextFormField(
                                controller: eighteenabove,
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
                                    hintText: "Type number of member above age 18"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          child: Text(
                            "Property No.",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Text(':'),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.60,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.80,
                              child: TextFormField(
                                controller: propertyNo,
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
                                    hintText: "Type number of member above age 18"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  // camera container
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MapContainer(
                      locationData: (s) async {
                        locationData = s;
                      },
                    ),
                  ),
                  widget.resident_opr ==
                      RESIDENT_OPR.update ?SizedBox():  GridImage(
                    images: this.images!,
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
                      bool coviddata = await residentProvider
                          .submitCovidDataFirstTime(context);

                      if (coviddata == false) {
                        "Something error in member form"
                            .showSnackbar(context);
                        return;
                      }else if(coviddata == true) {
                        "Form update Successfully".showSnackbar(context);
                        DashBoardScreen().  pushAndPopTillFirst(context);
                        return;
                      }
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
                        'business_type': _selected_Business_type?.name,
                        'house_address': shop_flat_address.text,
                        'owner_name': ownerName.text,
                        'propertyno': propertyNo.text,
                        'eighteenabove': eighteenabove.text,
                        'owner_mobile': owner_mobile_phno.text,
                        //   'owner_aadhar': owner_aadhaar.text,
                        'wastage_quantity': wastageQty.text,
                        'type': _selected_housetype?.type ?? "",
                        'existing_disposal':
                        _selected_disposal?.disposal ?? "",
                        'quality_waste': _select_quantity?.waste ?? "",
                        'latitude':
                        (this.locationData?.latitude)?.toString() ?? "",
                        'longitude':
                        (this.locationData?.longitude)?.toString() ?? "",
                        'images': [
                          for (var file in this.images!)
                            ...{
                              await MultipartFile.fromFile(file.path,
                                  filename: file.path
                                      .split('/')
                                      .last)
                            }.toList()
                        ]
                      });

                      MProgressIndicator.show(context);
                      ApiResponse res = await residentProvider
                          .performAddResident(formData, context);

                      print(res.status);
                      MProgressIndicator.hide();
                      if (res.status == 200) {
                        Timer.periodic(Duration(seconds: 2), (timer) async {
                          timer.cancel();
                          Navigator.pop(context);
                        });
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
}
