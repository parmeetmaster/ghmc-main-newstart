import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/complex_building/complex_add_model.dart';
import 'package:ghmc/model/culvert/area_model.dart';
import 'package:ghmc/provider/community_hall/community_hall.dart';
import 'package:ghmc/provider/complex_building/complex_building.dart';
import 'package:ghmc/provider/covid/covid_provider.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/util/extension.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/container/camera_container.dart';
import 'package:ghmc/widget/container/map_container.dart';
import 'package:ghmc/widget/covid_screen/covid_screen.dart';
import 'package:ghmc/widget/grid/grid_image.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/model/all_drop_down_model.dart' as alldrop;

import 'complex_building.dart';
import 'package:ghmc/util/utils.dart';

class CicrclueUserAccessComplex extends StatefulWidget {
  String id;

  CicrclueUserAccessComplex(this.id, {Key? key}) : super(key: key);

  @override
  _CicrclueUserAccessComplexState createState() =>
      _CicrclueUserAccessComplexState();
}

class _CicrclueUserAccessComplexState extends State<CicrclueUserAccessComplex> {
  double fontSize = 14.0;

  var landmark = TextEditingController();
  var name = TextEditingController();
  var address = TextEditingController();
  var floors = TextEditingController();
  String? _selectedbasement;
  String? _selectedGroundFloor;
  String? uuid;

  LocationData? locationData;

  List<File>? images = [];
  late final ComplexBuildingProvider provider;

  String? _selected_floor = null;
  Category_type? _selected_category_type = null;
  Business_type? _selected_Business_type = null;
  String selectBuisnessesident = "";
  Licence? _selected_license = null;
  Quality_waste? _select_quantity;
  Existing_disposal? _existing_disposal = null;
  TextStyle hintStyle = TextStyle(fontSize: 14);
  var Business_name = TextEditingController();

  var shop_flat_address = TextEditingController();

  var owner_name = TextEditingController();
  var property_no = TextEditingController();
  var owner_mobile_phno = TextEditingController();
  var owner_aadhaar = TextEditingController();
  Existing_disposal? _selected_disposal;
  CommunityHallProvider? comprovider;

  var wastageQty = TextEditingController();
  var familyMembercount = TextEditingController();

  alldrop.Type_of_house? _selected_housetype;
  Map<String, dynamic>? covidResponse;

  var text18above = TextEditingController();

  var text18below = TextEditingController();

  var complex_name = TextEditingController();

  @override
  void initState() {
    super.initState();
    comprovider = Provider.of<CommunityHallProvider>(context, listen: false);
    provider = Provider.of<ComplexBuildingProvider>(context, listen: false);
    provider.loadComplexName(widget.id);
    comprovider!.loadCommunityItems(context);
    provider.loadComplexBuilingDropDownOptions(widget.id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: FAppBar.getCommonAppBar(title: "Complex/Building Add Flat"),
        body: Consumer<ComplexBuildingProvider>(
            builder: (context, snapshot, child) {
              complex_name.text = provider.complexName?.data?.first?.name??"";
          return provider.complexAddModelDropDown != null &&
                  provider.complexName!= null
              ? ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Complex Name",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: complex_name,
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
                                        hintText: "Type Owner name here..."),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //floors
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Floor",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Floor'),
                                    isExpanded: true,
                                    value: _selected_floor,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider
                                        .complexAddModelDropDown!.data!.floor!
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("${value}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_floor = newValue;
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
                    //flat name:
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Flat Number",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                  controller: floors,
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
                                      hintText: "Enter flat number"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //categories
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Category Types",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                  child: DropdownButton<Category_type>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select category'),
                                    isExpanded: true,
                                    value: _selected_category_type,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider.complexAddModelDropDown!
                                        .data!.categoryType!
                                        .map<DropdownMenuItem<Category_type>>(
                                            (Category_type value) {
                                      return DropdownMenuItem<Category_type>(
                                        value: value,
                                        child: Text("${value.name}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selected_category_type = newValue;
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
                    //Business type and residental type
                    if (_selected_category_type != null &&
                        _selected_category_type!.name == "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "Business Type",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: provider.complexAddModelDropDown!
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
                                          selectBuisnessesident =
                                              newValue!.name!;
                                          ;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (_selected_category_type != null)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "Resident Type",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child:
                                        DropdownButton<alldrop.Type_of_house>(
                                      underline: Container(
                                        color: Colors.transparent,
                                      ),
                                      hint: Text('Select Resident'),
                                      isExpanded: true,
                                      value: _selected_housetype,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 20,
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: comprovider!
                                          .dropDowns!.data!.typeOfHouse!
                                          .map<
                                                  DropdownMenuItem<
                                                      alldrop.Type_of_house>>(
                                              (alldrop.Type_of_house value) {
                                        return DropdownMenuItem<
                                            alldrop.Type_of_house>(
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

                    //Business name:

                    if (_selected_category_type != null &&
                        _selected_category_type!.name == "Business")
                      if (_selected_category_type != null)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text(
                                  _selected_category_type!.name == "Business"
                                      ? "Business Name"
                                      : "Residential Name",
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              ),
                              Text(':'),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.64,
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
                                      controller: Business_name,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          hintStyle: hintStyle,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 11,
                                              right: 15),
                                          hintText: "Type  name here..."),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
//shop flat address :

                    if (_selected_category_type != null &&
                        _selected_category_type!.name == "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "Shop/Flat Address",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: TextFormField(
                                    controller: shop_flat_address,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        hintStyle: hintStyle,
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

//owner name:
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Owner Name",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                  controller: owner_name,
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
                                      hintText: "Type Owner name here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //owner mobile number:

                    // 18 plus memebers
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Owner Mobile Number",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                    if (_selected_category_type != null &&
                        _selected_category_type!.name != "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "18+ members",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: TextFormField(
                                    controller: text18above,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        hintStyle: hintStyle,
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
                    if (_selected_category_type != null &&
                        _selected_category_type!.name != "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "18 below Members",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: TextFormField(
                                    controller: text18below,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        hintStyle: hintStyle,
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

                    //owner adhaar number:

                    if (_selected_category_type != null &&
                        _selected_category_type!.name == "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "Owner Adhaar",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: TextFormField(
                                    controller: owner_aadhaar,
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
                                        hintStyle: hintStyle,
                                        hintText: "Type Owner Adhhaar number"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    //license number
                    if (_selected_category_type != null &&
                        _selected_category_type!.name == "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "License Number",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child: DropdownButton<Licence>(
                                      underline: Container(
                                        color: Colors.transparent,
                                      ),
                                      hint: Text('Selected License'),
                                      isExpanded: true,
                                      value: _selected_license,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 20,
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: provider.complexAddModelDropDown!
                                          .data!.licence!
                                          .map<DropdownMenuItem<Licence>>(
                                              (Licence value) {
                                        return DropdownMenuItem<Licence>(
                                          value: value,
                                          child: Text("${value.licence}"),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) async {
                                        setState(() {
                                          _selected_license = newValue;
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
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                    items: provider.complexAddModelDropDown!
                                        .data!.existingDisposal!
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Approx Quantity of waste",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                    hint: Text('Select Quantity'),
                                    isExpanded: true,
                                    value: _select_quantity,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: provider.complexAddModelDropDown!
                                        .data!.qualityWaste!
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
                    //Enter quantity
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Wastage Weight",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.64,
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
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintStyle: hintStyle,
                                      hintText: "Type wastage Quantity"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Add member

                    if (_selected_category_type != null &&
                        _selected_category_type!.name != "Business")
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                "Add Family Member Data",
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Text(':'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
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
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: GestureDetector(
                                    onTap: () async {
                                      covidResponse =
                                          await CovidScreen().push(context);
                                      if (covidResponse != null) {
                                        setState(() {
                                          uuid =
                                              covidResponse!["uuid"].toString();
                                          covidResponse.toString().printwtf;
                                          this.familyMembercount.text =
                                              covidResponse!["count"]
                                                  .toString();
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration:
                                          BoxDecoration(color: Colors.purple),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              this
                                                      .familyMembercount
                                                      .text
                                                      .isNotEmpty
                                                  ? "${covidResponse!["count"]} Member added"
                                                  : "Add Members",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
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
                    GridImage(
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
                        if (this.locationData == null) {
                          "Please choose location first".showSnackbar(context);
                          return;
                        }

                        if (_selected_category_type != null &&
                            _selected_category_type!.name != "Business") {
                          if (uuid == null) {
                            "No member is added in covid form please add least one member"
                                .showSnackbar(context);
                            return;
                          }
                        }

                        if (this.images!.length > 5) {
                          "Only max 5 images are allowed".showSnackbar(context);
                          return;
                        }

                        FormData formData = FormData.fromMap({
                          'user_id': Globals.userData!.data!.userId!,
                          'floor': this._selected_floor ?? "",
                          'floor_no': this.floors.text,
                          'category': this._selected_category_type?.name ?? "",
                          'business_type':
                              _selected_category_type?.name == "Business"
                                  ? this._selected_Business_type?.name ?? ""
                                  : this._selected_housetype?.type ?? "",
                          'business_name': this.Business_name.text,
                          'shop_address': this.shop_flat_address.text,
                          'owner_name': this.owner_name.text,
                          'owner_mobile': this.owner_mobile_phno.text,
                          'owner_aadhar': this.owner_aadhaar.text,
                          'licence_number':
                              this._selected_license?.licence ?? "",
                          'wastage_quantity': this.wastageQty.text,
                          'existing_disposal':
                              this._selected_disposal?.disposal ?? "",
                          'approx_quality_waste':
                              this._select_quantity?.waste ?? "",
                          'latitude': (this.locationData?.latitude).toString(),
                          'longitude': (this.locationData?.latitude).toString(),
                          'complex_id': widget.id,
                          'eighteenabove': text18above.text,
                          'eighteenbelow': text18below.text,
                          'resident_type': this._selected_housetype?.type ?? "",
                          'uuid': this.uuid ?? "",
                          'propertyno': this.property_no.text,
                          'images': [
                            for (var file in this.images!)
                              ...{
                                await MultipartFile.fromFile(file.path,
                                    filename: file.path.split('/').last)
                              }.toList()
                          ]
                        });

                        MProgressIndicator.show(context);
                        final provider = Provider.of<ComplexBuildingProvider>(
                            context,
                            listen: false);
                        ApiResponse res = await provider
                            .uploadComplexBuildingDetails(formData, context);
                        print(res.status);
                        if (res.status == 200) {
                          // new clear
                          final provider = Provider.of<CovidProvider>(context,
                              listen: false);
                          provider.covidModel.clear();
                          Navigator.pop(context);
                        }
                        MProgressIndicator.hide();
                      },
                    )
                  ],
                )
              : Loading();
        }));
  }

  @override
  void dispose() {
    super.dispose();
    provider.complexName=null;
  }
}
