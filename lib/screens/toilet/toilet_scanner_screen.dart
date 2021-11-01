import 'dart:io';

import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/model/all_drop_down_model.dart';
import 'package:ghmc/provider/toilet/toilet.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/border_grey_button.dart';
import 'package:ghmc/widget/card_seperate_row.dart';
import 'package:image_grid/grid_image.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';
class ToiletScanScreen extends StatefulWidget {
  const ToiletScanScreen({Key? key}) : super(key: key);

  @override
  _ToiletScanScreenState createState() => _ToiletScanScreenState();
}

class _ToiletScanScreenState extends State<ToiletScanScreen> {
  bool? choice=null;
  late ToiletProvider provider =
      Provider.of<ToiletProvider>(context, listen: false);

  var toiletName = TextEditingController();

  var wasteQty = TextEditingController();

  Toilets_scan_type? _selectedToiletType;

  TextEditingController owner_aadhaar=TextEditingController();

    List<File> images=[];

  var reason=TextEditingController();

  @override
  void initState() {
    super.initState();
    provider.loadCommunityItems(context);
    provider = Provider.of<ToiletProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Scanning Toilet Data"),
      body: Consumer<ToiletProvider>(builder: (context, value, child) {
        return ListView(
          padding: EdgeInsets.all(10),
          children: [
            CardSeperateRow("Toilet Name", "",fontsize: 16,),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Category Type", ""),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Incharge Name", ""),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Land", ""),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Area", ""),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Ward", ""),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Circle", ""),
            SizedBox(
              height: 5,
            ),
            CardSeperateRow("Zone", ""),
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
                      style: TextStyle(fontSize: 18),
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
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
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
                            items: provider.dropDowns!.data!.toiletsScanType!
                                .map<DropdownMenuItem<Toilets_scan_type>>(
                                    (Toilets_scan_type value) {
                              return DropdownMenuItem<Toilets_scan_type>(
                                value: value,
                                child: Text("${value.name}",style: TextStyle(fontSize: 18),),
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
            _getPickedGarbage()
          ],
        );
      }),
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
              Expanded(child: BorderedGreyButton(onclick: (){
               setState(() {
                 choice=true;
               });
              },
                  text: "Picked",
              spashColor:Colors.green,
                enable:choice==true?true:null
              )),
              SizedBox(width: 20,),
              Expanded(child: BorderedGreyButton(onclick: (){
               setState(() {
                 choice=false;
               });
              },
                  text: "Denied",
                  spashColor:Colors.red,
                  enable:choice==false?true:null
              )),
            ],
          ),   SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text(
                    "Approx Quantity \n(kg/tons) ",
                    style: TextStyle(fontSize: 18),
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
                            hintStyle: TextStyle(fontSize: 16),
                            hintText: "Type Quantity"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if(choice==false)
            Container(
              width: MediaQuery.of(context).size.width ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text(
                      "Reason",
                      style: TextStyle(fontSize: 18),
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
                              hintStyle: TextStyle(fontSize: 16),
                              hintText: "Type Reason"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 20,),
          GridImage(
            bottomsheetTitle: "Please Take Live Picture",
            images:   this.images! ,
            title: "Select Images",
            context: context,
            onlyCamera: true,
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
        ],
      ),
    );
  }
}
