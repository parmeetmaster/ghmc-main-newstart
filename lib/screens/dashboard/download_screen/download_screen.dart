import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/dashboard/new_zone_model.dart';
import 'package:ghmc/model/dashboard/vehicle_table_model.dart';
import 'package:ghmc/model/dashboard/zone_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/util/utils.dart';
import 'package:intl/intl.dart';

class DownloadViewScreenDashboard extends StatefulWidget {
  DateTime? startDate;
  DateTime? endDate;

  dynamic selected_zone;
  MenuItem? selected_circle;
  MenuItem? selected_vehicle;

  DownloadViewScreenDashboard({
    this.startDate,
    this.endDate,
    this.selected_vehicle,
    this.selected_zone,
    this.selected_circle,
  });

  @override
  _DownloadViewScreenDashboardState createState() =>
      _DownloadViewScreenDashboardState();
}

class _DownloadViewScreenDashboardState
    extends State<DownloadViewScreenDashboard> {
  VehicleTableModel? table_report;

  @override
  void initState() {
    super.initState();
    Globals.userData!.data!.userId!.printwtf;
    loadReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF9C27B0),
                Color(0xFFF06292),
                Color(0xFFFF5277),
              ],
            ),
          ),
        ),
        title: const Text('Dashboard download sheet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Download',
            onPressed: () {
              final provider = DashBoardProvider.getReference(context);

              provider.downloadMasterFile(
                context: context,
                startDate: widget.startDate,
                endDate: widget.endDate,
                selected_zone: widget.selected_zone,
                selected_vehicle: widget.selected_vehicle,
                selected_circle: widget.selected_circle,
                selected_transfer_station: null,
                filename: 'VEHICLE-MASTER',
                operation: downloadType.vehicle_type,
              );
            },
          ),
        ],
      ),
      body: table_report != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: DataTable2(
                headingTextStyle: TextStyle(
                    fontWeight: FontWeight.w800, color: Colors.black87),
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 2000,
                dataRowHeight: 80,
                columns: [
                  if (table_report != null)
                    ...table_report!.data!.columns!.map(
                      (e) => DataColumn(
                        label: Text(e.camelCase),
                      ),
                    ),
                ],
                rows: [
                  if (table_report != null)
                    ...table_report!.data!.rows!.mapIndexed(
                      (e, index) => DataRow(
                        color: (index + 1) % 2 == 0
                            ? MaterialStateProperty.all(Colors.grey[200])
                            : MaterialStateProperty.all(Colors.transparent),
                        cells: [
                          ...e.map((e) => DataCell(Text("${e}"))),
                        ],
                      ),
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

  loadReport() async {
    DateFormat format = new DateFormat("dd-MM-yyyy");

    ApiResponse? response = await DashBoardProvider.getReference(context)
        .getReport(
            startdate: format.format(widget.startDate!),
            enddate: format.format(widget.endDate!),
            zone: widget.selected_zone,
            circle: widget.selected_circle,
            vehicle: widget.selected_vehicle);
    if (response!.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    table_report = VehicleTableModel.fromJson(response.completeResponse);
    // table_report!.data!.columns!.length.toString().printwarn;

    // this block for testing purposes
    if (mode == modes.testing) {
      table_report!.data!.rows!.forEach(
        (element) {
          " Coloumn count ${table_report!.data!.columns!.length.toString()} Row count ${element.length.toString()}"
              .printwarn;
          if (table_report!.data!.columns!.length != element.length) {
            "This not compatable data ${element}".printwarn;
          }
        },
      );
    }

    setState(() {});
  }
}
