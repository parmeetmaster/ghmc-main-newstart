import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/model/support/support_types.dart';
import 'package:ghmc/provider/support/support.dart';
import 'package:ghmc/screens/complaint_box/step_progress_indicator.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
//import 'package:ghmc/util/recording.dart';
import 'package:ghmc/util/utils.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:provider/provider.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);

  @override
  _ComplainScreenState createState() => _ComplainScreenState();
}

class _ComplainScreenState<T> extends State<ComplainScreen> {
  // RecodingAudioPlayer? recorder;
  Icon? icon;
  Color color = Colors.red;
  int currunt_step = 0;
  SupportTypes? supportTypes;
  File? photo;
  TextEditingController controller = new TextEditingController();

  SupportItems? supportItem;

  @override
  void initState() {
    super.initState();
    loadData();

    //startRecording();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Complaint"),
        body: (supportTypes == null)
            ? Center(
              child: CircularProgressIndicator(),
            )
            : Container(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 340,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          isExpanded: true,
                          //value: selectedOwnerType,
                          onChanged: (value) {
                            this.supportItem = value as SupportItems;
                            setState(() {});
                          },

                          items: supportTypes!.data!
                              .map((e) => DropdownMenuItem<SupportItems>(
                                    value: e,
                                    child: Text("${e.name}"),
                                  ))
                              .toList(),
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
                              supportItem == null
                                  ? "Select Complaint"
                                  : "${supportItem!.name}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: controller,
                          minLines: 1,
                          //Normal textInputField will be displayed
                          maxLines: 5,
                          //
                          keyboardType: TextInputType.multiline,
                          decoration: new InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: Color(0xFFAD1457), width: 0.0),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Type in your Complaint here...",
                              fillColor: Colors.white70),
                        )),
                    SizedBox(
                      height: 25,
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FloatingActionButton(
                                        backgroundColor: Colors.black,
                                        onPressed: () async {
                                          // photo =
                                          //     await FilePick().takecameraPic();
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
                                    FloatingActionButton(
                                        backgroundColor: Colors.black,
                                        onPressed: () async {
                                          photo = await FilePick().pickFile();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.picture_in_picture_sharp,
                                          color: Colors.white,
                                          size: 40,
                                        ),),
                                  ],
                                ),
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
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: InkWell(
                        onTap: () async {
                          MProgressIndicator.show(context);
                          if (validation() != true) {
                            return;
                          }
                          final provider = Provider.of<SupportProvider>(context,
                              listen: false);
                          ApiResponse? response = await provider.submitComplaint(
                              item: this.supportItem,
                              controller: this.controller,
                              photo: this.photo,
                              context: context);

                          MProgressIndicator.hide();

                          SingleButtonDialog(
                            message: response!.message!,
                            imageurl: "assets/svgs/satisfaction.svg",
                            onOk: (c) {
                              DashBoardScreen().pushAndPopAll(context);
                            },
                          ).pushDialog(context);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                'Submit Complaint',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFAD1457),
                                  Color(0xFFAD801D9E)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  void loadData() async {
    final provider = Provider.of<SupportProvider>(context, listen: false);
    ApiResponse? response = await provider.getSupporTypes();
    supportTypes = SupportTypes.fromJson(response!.completeResponse);
    setState(() {});
  }

  validation() {
    if (this.supportItem == null) {
      "Please Select Complaint Type".showSnackbar(context);
      return false;
    }
    /*else if (controller.text.isEmpty) {
      "Please type your Complaint".showSnackbar(context);
      return false;
    } else if (this.photo == null) {
      "Please add Photograph".showSnackbar(context);
      return false;
    }*/
    return true;
  }

/*
   _getDropDown(dynamic f) {
    return Padding(
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
              this.selected_transferStation = val as TransferTypeDataItem?;
              setState(() {});
            },
            // validation to check not null
            items: this.transferStations == null
                ? []
                : this
                    .transferStations!
                    .data!
                    .map((e) => DropdownMenuItem<TransferTypeDataItem>(
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
    );
  }
*/

}
