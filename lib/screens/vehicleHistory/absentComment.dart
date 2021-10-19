import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/userHistory/absentVehiclesComment_model.dart';
import 'package:ghmc/provider/userHistory_provider/logHistory_provider.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';

import 'absentVehicle.dart';

class AbsentComment extends StatefulWidget {
  String? id;
  String? type;
  String? vehicleNo;
  String? sfaName;
  String? sfaNo;
  String? landmark;
  String? ward;
  String? circle;
  String? zone;

  AbsentComment({
    Key? key,
    this.id,
    this.type,
    this.vehicleNo,
    this.sfaName,
    this.sfaNo,
    this.landmark,
    this.ward,
    this.circle,
    this.zone,
  }) : super(key: key);

  @override
  _AbsentCommentState createState() => _AbsentCommentState(
        id: id,
        type: type,
        vehicleNo: vehicleNo,
        sfaName: sfaName,
        sfaNo: sfaNo,
        landmark: landmark,
        ward: ward,
        circle: circle,
        zone: zone,
      );
}

class _AbsentCommentState extends State<AbsentComment> {
  String? id;
  String? type;
  String? vehicleNo;
  String? sfaName;
  String? sfaNo;
  String? landmark;
  String? ward;
  String? circle;
  String? zone;

  _AbsentCommentState({
    this.id,
    this.type,
    this.vehicleNo,
    this.sfaName,
    this.sfaNo,
    this.landmark,
    this.ward,
    this.circle,
    this.zone,
  });

  List<String> comment = [
    'Absent',
    'Vehicle not coming to field',
    'Vehicle is not coming to assembly place',
    'No Information',
    'Others',
  ];

  String? commentValue;

  AbsentVehiclesComment? data;

  final TextEditingController _textController = TextEditingController();

  Future<void> _postAbsentVehiclesComment(String id, String comment) async {
    final logHistoryProvider =
        Provider.of<LogHistoryProvider>(context, listen: false);
    ApiResponse? resp = await logHistoryProvider.absentVehiclesComment(
      id,
      comment,
    );
    if (resp!.status == 200) {
      print('${resp.completeResponse}');
      data = AbsentVehiclesComment.fromJson(resp.completeResponse);
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Comment"),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            children: [
              SizedBox(height: 23.0),
              _getRowKeyValueDetails(
                key: 'Type',
                value: '$type',
              ),
              _getRowKeyValueDetails(
                key: 'Vehicle No',
                value: '$vehicleNo',
              ),
              _getRowKeyValueDetails(
                key: 'SFA Name',
                value: '$sfaName',
              ),
              _getRowKeyValueDetails(
                key: 'SFA Number',
                value: '$sfaNo',
              ),
              _getRowKeyValueDetails(
                key: 'Landmark',
                value: '$landmark',
              ),
              _getRowKeyValueDetails(
                key: 'Ward',
                value: '$ward',
              ),
              _getRowKeyValueDetails(
                key: 'Circle',
                value: '$circle',
              ),
              _getRowKeyValueDetails(
                key: 'Zone',
                value: '$zone',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
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
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      child: DropdownButton(
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        menuMaxHeight: 500.0,
                        isExpanded: true,
                        hint: Text('Comment'),
                        value: commentValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        items: comment
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            commentValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              commentValue == 'Others'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          maxLines: 5,
                          controller: _textController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Information ...',
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 100.0),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        child: TextButton(
            onPressed: () async {
              MProgressIndicator.show(context);
              if (this.commentValue == null) {
                showSnackbar(context, 'Please select transfer station');
                return;
              }
              await _postAbsentVehiclesComment(
                id!,
                commentValue != 'Others' ? commentValue! : _textController.text,
              );
              MProgressIndicator.hide();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AbsentVehicle(),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Widget _getRowKeyValueDetails({String? key, String? value}) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(key!),
          ),
        ),
        Text(':'),
        Container(
          width: MediaQuery.of(context).size.width * 0.58,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value!),
          ),
        ),
      ],
    );
  }

  showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Color(0xff4d159e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
