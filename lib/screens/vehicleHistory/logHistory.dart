import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/userHistory/logHistory_model.dart';
import 'package:ghmc/provider/userHistory_provider/logHistory_provider.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';

class VehicleHistory extends StatefulWidget {
  const VehicleHistory({Key? key}) : super(key: key);

  @override
  _VehicleHistoryState createState() => _VehicleHistoryState();
}

class _VehicleHistoryState extends State<VehicleHistory> {
  LogHistory? data;

  @override
  void initState() {
    Future.wait([_getLogHistory()]);
    super.initState();
  }

  Future<void> _getLogHistory() async {
    final logHistoryProvider =
        Provider.of<LogHistoryProvider>(context, listen: false);
    ApiResponse? resp = await logHistoryProvider.getLogHistory();
    if (resp!.status == 200)
    {
      print('${resp.completeResponse}');
      data = LogHistory.fromJson(resp.completeResponse);
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Log History"),
      body: (data != null)
          ? _buildBody(context)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildBody(BuildContext context) {
    return data!.data!.length != 0
        ? ListView.builder(
            itemCount: data!.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = data!.data![index];
              List<String> date = '${item.date}'.split(' ').toList();
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _getRowKeyValueDetails(
                          key: 'Date',
                          value: '${item.date}',
                        ),
                        Divider(color: Colors.black),
                        _getRowKeyValueDetails(
                          key: 'Vehicle Type',
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
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(child: Text('No data added yet'));
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
