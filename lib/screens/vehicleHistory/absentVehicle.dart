import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/model/userHistory/absentVehicles_model.dart';
import 'package:ghmc/provider/userHistory_provider/logHistory_provider.dart';
import 'package:ghmc/screens/vehicleHistory/absentComment.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';

class AbsentVehicle extends StatefulWidget {
  const AbsentVehicle({Key? key}) : super(key: key);

  @override
  _AbsentVehicleState createState() => _AbsentVehicleState();
}

class _AbsentVehicleState extends State<AbsentVehicle> {
  List<String> satList = [
    'All Vehicle',
    'SAT Vehicle',
    'Secondary Vehicle',
  ];

  String? satListValue = 'All Vehicle';

  String? initialValue = 'all';

  AbsentVehicleModel? data;

  @override
  void initState() {
    Future.wait([_getAbsentVehicles(initialValue!)]);
    super.initState();
  }

  Future<void> _getAbsentVehicles(String value) async {
    final logHistoryProvider =
        Provider.of<LogHistoryProvider>(context, listen: false);
    ApiResponse? resp = await logHistoryProvider.absentVehicles(value);
    if (resp!.status == 200) {
      print('${resp.completeResponse}');
      data = AbsentVehicleModel.fromJson(resp.completeResponse);
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Absent Vehicle"),
      body: (data != null)
          ? _buildBody(context)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0),
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
                  value: satListValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  items: satList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    MProgressIndicator.show(context);
                    setState(() {
                      satListValue = newValue!;
                    });
                    if (satListValue == 'All Vehicle') {
                      await _getAbsentVehicles(initialValue!);
                    } else {
                      String? intDropdownValue =
                          satListValue == 'SAT Vehicle' ? '0' : '1';
                      await _getAbsentVehicles(intDropdownValue);
                    }
                    MProgressIndicator.hide();
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data!.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = data!.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _getRowKeyValueDetails(
                          key: 'Type',
                          value: '${item.vechileType}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'Vehicle No',
                          value: '${item.vechileRegistrationNumber}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'SFA Name',
                          value: '${item.sfaName}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'SFA Number',
                          value: '${item.sfaMobileNumber}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'Landmark',
                          value: '${item.landmark}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'Ward',
                          value: '${item.wardName}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'Circle',
                          value: '${item.circle}',
                        ),
                        _getRowKeyValueDetails(
                          key: 'Zone',
                          value: '${item.zone}',
                        ),
                        item.commentUpdate == "no"
                            ? _commentButton(context, item)
                            : _commentedButton(context),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _commentButton(BuildContext context, Datum item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AbsentComment(
                    id: item.id,
                    type: item.vechileType,
                    vehicleNo: item.vechileRegistrationNumber,
                    sfaName: item.sfaName,
                    sfaNo: item.sfaMobileNumber,
                    landmark: item.landmark,
                    ward: item.wardName,
                    circle: item.circle,
                    zone: item.zone,
                  ),
                ),
              );
            },
            child: Text(
              'Comment',
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

  Widget _commentedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        child: TextButton(
            onPressed: () => null,
            child: Text(
              'Commented',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6CC06B),
              Color(0xff3AB370),
            ],
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
}
