import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/all_drop_down_model.dart';
import 'package:ghmc/provider/toilet/toilet.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/border_grey_button.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/card_seperate_row.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:image_grid/grid_image.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

class ToiletScanScreen extends StatefulWidget {
  final qrdata;

  const ToiletScanScreen({Key? key, this.qrdata}) : super(key: key);

  @override
  _ToiletScanScreenState createState() => _ToiletScanScreenState();
}

class _ToiletScanScreenState extends State<ToiletScanScreen> {
  bool? choice = null;
  late ToiletProvider provider =
      Provider.of<ToiletProvider>(context, listen: false);

  var toiletName = TextEditingController();

  var wasteQty = TextEditingController();

  Toilets_scan_type? _selectedToiletType;

  TextEditingController qty_no = TextEditingController();

  List<File> images = [];

  var reason = TextEditingController();

  Toilets_scan_reason? _selectedToiletReason;

  String? _weight;

  @override
  void initState() {
    super.initState();
    provider.loadCommunityItems(context);
    provider = Provider.of<ToiletProvider>(context, listen: false);
    provider.loadResidentDisplayData(widget.qrdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Toilet"),
      body: Consumer<ToiletProvider>(builder: (context, value, child) {
        return provider.dropDowns != null && provider.scanToiletModel != null
            ? ListView(
                padding: EdgeInsets.all(10),
                children: [
                  CardSeperateRow(
                    "Toilet Name",
                    provider.scanToiletModel!.data!.templeName,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Category Type",
                    provider.scanToiletModel!.data!.dbType,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Incharge Name",
                    provider.scanToiletModel!.data!.inchargeName,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Land",
                    provider.scanToiletModel!.data!.landmark,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Area",
                    provider.scanToiletModel!.data!.area,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Ward",
                    provider.scanToiletModel!.data!.wardName,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Circle",
                    provider.scanToiletModel!.data!.circle,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardSeperateRow(
                    "Zone",
                    provider.scanToiletModel!.data!.zone,
                    fontsize: 16,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Text(
                            "Type",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(":", style: TextStyle(fontSize: 22)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
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
                                child: DropdownButton<Toilets_scan_type>(
                                  underline: Container(
                                    color: Colors.transparent,
                                  ),
                                  hint: Text('Select Toilet Type'),
                                  isExpanded: true,
                                  value: _selectedToiletType,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  items: provider
                                      .dropDowns!.data!.toiletsScanType!
                                      .map<DropdownMenuItem<Toilets_scan_type>>(
                                          (Toilets_scan_type value) {
                                    return DropdownMenuItem<Toilets_scan_type>(
                                      value: value,
                                      child: Text(
                                        "${value.name}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) async {
                                    setState(() {
                                      _selectedToiletType = newValue!;
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
                  if (_selectedToiletType?.name != null &&
                      _selectedToiletType!.name == "Picking Garbage")
                    _getPickedGarbage()
                  else
                    _getCleaning(),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: GradientButton(
                      onclick: () async{
                        FormData formdata= FormData.fromMap({
                          'user_id': Globals.userData?.data?.userId ?? "",
                          'collection_id':
                              provider.scanToiletModel?.data?.colId ?? "",
                          'wt_type': _weight,
                          'picked_denied':
                              choice == null || choice == false ? 0 : 1,
                          'approx_weight': qty_no.text,
                          'reason': reason.text,
                          'operation_type': _selectedToiletType?.name ?? "",
                          'reason_type': _selectedToiletReason?.name ?? "",
                          'reason_type_description': reason.text,
                          'images': [
                            for (var file in this.images)
                              ...{
                                await MultipartFile.fromFile(file.path,
                                    filename: file.path.split('/').last)
                              }.toList()
                          ]
                        });
                        provider.submitScannedToiletData(formdata,context);


                      },
                      title: "Submit",
                    ),
                  )
                ],
              )
            : Loading();
      }),
    );
  }

  _getCleaning() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text(
                    "Reason",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(":", style: TextStyle(fontSize: 22)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: DropdownButton<Toilets_scan_reason>(
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          hint: Text('Select Reason'),
                          isExpanded: true,
                          value: _selectedToiletReason,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          items: provider.dropDowns!.data!.toiletsScanReason!
                              .map<DropdownMenuItem<Toilets_scan_reason>>(
                                  (Toilets_scan_reason value) {
                            return DropdownMenuItem<Toilets_scan_reason>(
                              value: value,
                              child: Text(
                                "${value.name}",
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            setState(() {
                              _selectedToiletReason = newValue!;
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
          if (_selectedToiletReason != null &&
              _selectedToiletReason!.name!.toLowerCase() == "damages")
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text(
                      "Damages",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(":", style: TextStyle(fontSize: 22)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
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
                          controller: reason,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintStyle: TextStyle(fontSize: 16),
                              hintText: "Detail about damage..."),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 20,
          ),
          GridImage(
            bottomsheetTitle: "Please Take Live Picture",
            images: this.images,
            title: "Select Images",
            context: context,
            onlyCamera: true,
            onchange: (List<File> files) async {
              MProgressIndicator.show(context);
              try {
                List<File>? tempimages = [];
                await Future.forEach(files, (e) async {
                  print(e);
                  File? file = await FileSupport().compressImage(e as File);
                  tempimages.add(file!);
                });
                this.images.clear();
                "${tempimages.length} are compress".toString().printwtf;
                this.images.addAll(tempimages);
              } catch (e) {
                MProgressIndicator.hide();
              }
              MProgressIndicator.hide();
            },
          ),
        ],
      ),
    );
  }

  _getPickedGarbage() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: BorderedGreyButton(
                      onclick: () {
                        setState(() {
                          choice = true;
                        });
                      },
                      text: "Picked",
                      spashColor: Colors.green,
                      enable: choice == true ? true : null)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: BorderedGreyButton(
                      onclick: () {
                        setState(() {
                          choice = false;
                        });
                      },
                      text: "Denied",
                      spashColor: Colors.red,
                      enable: choice == false ? true : null)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          if(choice==true)
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text(
                    "Approx Quantity \n(kg/tons) ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(":", style: TextStyle(fontSize: 22)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        controller: qty_no,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintStyle: TextStyle(fontSize: 16),
                            hintText: "Type Quantity"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(choice==true)
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text(
                    "Select Weight ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(":", style: TextStyle(fontSize: 22)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: DropdownButton<String>(
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          hint: Text('Select Weight'),
                          isExpanded: true,
                          value: _weight,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          items: ["killos", "tons"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                "${value}",
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            setState(() {
                              _weight = newValue!;
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
          if (choice == false)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text(
                      "Reason",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(":", style: TextStyle(fontSize: 22)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
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
                          controller: reason,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintStyle: TextStyle(fontSize: 16),
                              hintText: "Type Reason"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if(choice==true)
          SizedBox(
            height: 20,
          ),
          if(choice==true)
          GridImage(
            bottomsheetTitle: "Please Take Live Picture",
            images: this.images,
            title: "Select Images",
            context: context,
            onlyCamera: true,
            onchange: (List<File> files) async {
              MProgressIndicator.show(context);
              try {
                List<File>? tempimages = [];
                await Future.forEach(files, (e) async {
                  print(e);
                  File? file = await FileSupport().compressImage(e as File);
                  tempimages.add(file!);
                });
                this.images.clear();
                "${tempimages.length} are compress".toString().printwtf;
                this.images.addAll(tempimages);
              } catch (e) {
                MProgressIndicator.hide();
              }
              MProgressIndicator.hide();
            },
          ),
        ],
      ),
    );
  }
}
