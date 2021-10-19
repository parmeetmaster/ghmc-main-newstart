import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/dashboard/dashboard_vehicle.dart';
import 'package:ghmc/model/dashboard/new_zone_model.dart';
import 'package:ghmc/model/dashboard/tab/culvert/culvert_dash_board_model.dart';
import 'package:ghmc/model/dashboard/tab/transfer_station/transfer_station_tab_model.dart';
import 'package:ghmc/model/dashboard/zone_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/screens/dashboard/download_screen/download_screen.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/dashboard_screen/dashboard_grid_button.dart';
import 'package:ghmc/util/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DashBoardBody extends StatefulWidget {
  const DashBoardBody({Key? key}) : super(key: key);

  @override
  _UserDashBoard2State createState() => _UserDashBoard2State();
}

class _UserDashBoard2State extends State<DashBoardBody> {
  int tab_index =
      0; // primary variable control start download index switching and download operations

  DateTime? startDate;
  DateTime? endDate;
  DashboardVehicleModel? _dashboardVehicleModel;
  DashboardVehicleModel? _dashboardGvpBepModel;
  MenuItem? _selected_zone;
  NewMenuItemModel? new_zones;
  MenuItemModel? vehicle_type; // used to show dialog with item on dashboard
  NewMenuItem? _new_selected_zone;
  MenuItem? _selected_vehicle;
  MenuItem? _selected_transfer_station;
  MenuItem? _selected_circle;
  String? status;
  TransferStationTabModel? _dashboardTransferStationTabModel;
  CulvertDashBoardModel? _dashboardCulvertModel;

  Future<void> _getNewZones() async {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    ApiResponse? resp = await dashBoardProvider.postZones();
    if (resp.status == 200) {
      print('${resp.completeResponse}');
      new_zones = NewMenuItemModel.fromJson(resp.completeResponse);
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  Future<void> _setVehicleType() async {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    ApiResponse? resp = await dashBoardProvider.getVehicleType();
    if (resp.status == 200) {
      print('${resp.completeResponse}');
      vehicle_type = MenuItemModel.fromJson(resp.completeResponse);
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  initialLode() async {
    await DashBoardProvider.getReference(context).initialisation(context);
  }

  @override
  void initState() {
    initialLode();
    super.initState();
    Globals.userData!.data!.token!.toString().printwtf;
    /*  updateVehicleData(DateTime.now());
    getTransferStationData();*/
    Future.wait([
      _getNewZones(),
      // _setVehicleType(),
      updateVehicleData(),
      getTransferStationData(),
      updateGvpAndBep(),
      updateCulvert(),
    ]);
  }

  _resetDashBoard() {
    startDate = null;
    endDate = null;
    _selected_zone = null;
    _selected_vehicle = null;
    _selected_transfer_station = null;
    _selected_circle = null;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_dashboardTransferStationTabModel != null ||
        _dashboardVehicleModel != null)
      return Consumer<DashBoardProvider>(builder: (context, value, child) {
        // 📑 tabs at top
        Widget master_tab = Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          // show above tabs shifters as per index and true condition shows 2 tabs and 3 show while false
          /*userindex == "1" ?*/
          child: Card(
            child: IntrinsicHeight(
              child: Scrollbar(
                thickness: 1.4,
                hoverThickness: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 500,
                    child: Flex(
                      mainAxisSize: MainAxisSize.min,
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 8,
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tab_index = 0;
                                  _resetDashBoard();
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                "Vehicles",
                                style: TextStyle(
                                  color: tab_index == 0
                                      ? Color(0xffE33535)
                                      : Color(0xff2796B7),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey[500],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 8,
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tab_index = 1;
                                  _resetDashBoard();
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                "GVP / BEP",
                                style: TextStyle(
                                  color: tab_index == 1
                                      ? Color(0xffE33535)
                                      : Color(0xff2796B7),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey[500],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 10,
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tab_index = 2;
                                  _resetDashBoard();
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                "Transfer Station",
                                style: TextStyle(
                                  color: tab_index == 2
                                      ? Color(0xffE33535)
                                      : Color(0xff2796B7),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey[500],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 10,
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tab_index = 3;
                                  _resetDashBoard();
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                "Culvert",
                                style: TextStyle(
                                  color: tab_index == 3
                                      ? Color(0xffE33535)
                                      : Color(0xff2796B7),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        );

        // 🚌 this is above 4 button set of gvp and bep
        Widget button_grid_vehicles_and_gep_bep = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: (2.8 / 1),
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              //physics:BouncingScrollPhysics(),
              padding: EdgeInsets.all(10.0),
              children: [
                // zone container
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (c) {
                        return AlertDialog(
                          content: Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * .8),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "Select Zone",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ...new_zones!.data!.map(
                                      (e) => InkWell(
                                        child: DropdownMenuItem(
                                          child: Text("${e.name}"),
                                          onTap: () {},
                                        ),
                                        onTap: () {
                                          print("Clicked");
                                          _new_selected_zone = e;
                                          _selected_circle = null;
                                          Navigator.pop(c);
                                          MProgressIndicator.show(context);
                                          value.getCirclesForVehicles(
                                              _new_selected_zone);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          _new_selected_zone == null
                              ? "Zones"
                              : _new_selected_zone!.name ?? "Zone Undefined",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffF24169),
                          Color(0xffF4754C),
                        ],
                      ),
                    ),
                  ),
                ),
                //Circle type
                InkWell(
                  onTap: () {
                    if (value.circles == null) {
                      "Please Select Zone First".showSnackbar(context);
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (c) {
                        return AlertDialog(
                          content: Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * .8),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListTile(
                              title: Text(
                                "Circle",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              subtitle: ListView(
                                shrinkWrap: true,
                                children: [
                                  ...value.circles!.data!.map(
                                    (e) => InkWell(
                                      child: DropdownMenuItem(
                                        child: Text(
                                          "${e.name!.camelCase}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onTap: () {},
                                      ),
                                      onTap: () {
                                        print("Clicked");
                                        _selected_circle = e;
                                        Navigator.pop(c);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: Text(
                            _selected_circle == null
                                ? "Circles"
                                : _selected_circle!.name!.camelCase,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(colors: [
                          Color(0xFF80CBC4),
                          Color(0xFF00796B),
                        ])),
                  ),
                ),
                //vehicle type
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (c) {
                        return AlertDialog(
                          content: Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * .8),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "Select Vehicle Type",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ...value.vehicle_type!.data!.map(
                                      (e) => InkWell(
                                        child: DropdownMenuItem(
                                          child: Text("${e.name!.camelCase}"),
                                          onTap: () {},
                                        ),
                                        onTap: () {
                                          print("Clicked");
                                          _selected_vehicle = e;
                                          Navigator.pop(c);
                                          setState(
                                            () {},
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: Text(
                            _selected_vehicle == null
                                ? "Vehicle Type"
                                : _selected_vehicle!.name!.camelCase,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff6CC06B),
                          Color(0xff3AB370),
                        ],
                      ),
                    ),
                  ),
                ),
                // date selection
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          content: Container(
                            height: 350,
                            width: MediaQuery.of(ctx).size.width * 0.8,
                            color: Colors.white,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                SfDateRangePicker(
                                  onSelectionChanged: (s) {
                                    DateRangePickerSelectionChangedArgs
                                        dateargs = s;
                                    startDate = dateargs.value.startDate;
                                    endDate = dateargs.value.endDate;
                                    //   setState(() {});
                                  },
                                  maxDate: DateTime.now(),
                                  startRangeSelectionColor: Colors.green[500],
                                  endRangeSelectionColor: Colors.red[500],
                                  selectionColor: Colors.pink,

                                  // todayHighlightColor: Colors.pink,
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                ),
                                GradientButton(
                                  onclick: () {
                                    Navigator.pop(ctx);
                                    setState(() {});
                                    if (startDate == null || endDate == null) {
                                      "Please choose Start Date and End Date"
                                          .showSnackbar(context);
                                    }
                                  },
                                  title: "Done",
                                  height: 15,
                                  fontsize: 14,
                                  padding: 4,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        if (startDate == null || endDate == null)
                          Text(
                            "Select Date",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),

                        if (startDate != null && endDate != null)
                          Text(
                            startDate != null
                                ? "Start Date : " +
                                    DateFormat.yMMMMd().format(startDate!) +
                                    "\n" +
                                    "End Date : " +
                                    DateFormat.yMMMMd()
                                        .format(endDate ?? DateTime.now())
                                : "Select Date",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        SizedBox(
                          width: 7,
                        ),
                        // icon not display while date is avaiable
                        if (startDate == null)
                          Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                            size: 25,
                          )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff58B9EC),
                          Color(0xff4065AC),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // view downloads
            Center(
              child: InkWell(
                onTap: () {
                  _download_master_file();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "View Download",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff935498),
                        Color(0xff6D58A3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

        // 🚌 only vehicles and gvp bep with 2 tabs
        Widget vehicles_and_gvp_bep = Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              button_grid_vehicles_and_gep_bep,
              //1️⃣ vehicle title with 4 buttons here
              if (tab_index == 0)
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    children: [
                      if (_dashboardVehicleModel != null)
                        ..._dashboardVehicleModel!.data!.map(
                          (item) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.tag}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                childAspectRatio: (1.5 / 1),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 2,
                                //physics:BouncingScrollPhysics(),
                                children: [
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                          tabindex: tab_index,
                                          url: item.totalUrl!,
                                          name: "Total");
                                      // value.downloadFile(context: context, filename: "Vehicle-Attend-${DateTime.now().toString()}", url: item.attendUrl!);
                                    },
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xffF24169),
                                          Color(0xffF4754C),
                                        ],
                                        header: "Total",
                                        amount: "${item.total}"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                          tabindex: tab_index,
                                          url: item.attendUrl!,
                                          name: "Attend");
                                    },
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xff67C7E3),
                                          Color(0xff5AAADC),
                                        ],
                                        header: "Attend",
                                        amount: "${item.attend}"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                          tabindex: tab_index,
                                          url: item.notAttendUrl!,
                                          name: "Non-Attend");
                                    },
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xffEF788D),
                                          Color(0xffF078A8),
                                        ],
                                        header: "Not Attend",
                                        amount: "${item.notAttend}"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                          tabindex: tab_index,
                                          url: item.tsTripsUrl!,
                                          name: "Trips");
                                    },
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xff3AB370),
                                          Color(0xff6CC06B),
                                        ],
                                        header: "Trips",
                                        amount: "${item.tsTrips}"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      if (_dashboardVehicleModel == null)
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primary_color,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              //2️⃣ GVP AND BEP
              if (tab_index == 1)
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    children: [
                      if (_dashboardGvpBepModel != null)
                        ..._dashboardGvpBepModel!.data!.map(
                          (item) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.tag}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                childAspectRatio: (1.5 / 1),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 2,
                                //physics:BouncingScrollPhysics(),
                                children: [
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                          tabindex: tab_index,
                                          url: item.totalUrl!,
                                          name: "Total");
                                      // value.downloadFile(context: context, filename: "Vehicle-Attend-${DateTime.now().toString()}", url: item.attendUrl!);
                                    },
                                    child: DashBoardItemButton(
                                      color_grid: [
                                        Color(0xffF24169),
                                        Color(0xffF4754C),
                                      ],
                                      header: "Total",
                                      amount: "${item.total}",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                          tabindex: tab_index,
                                          url: item.attendUrl!,
                                          name: "Attend");
                                    },
                                    child: DashBoardItemButton(
                                      color_grid: [
                                        Color(0xff67C7E3),
                                        Color(0xff5AAADC),
                                      ],
                                      header: "Attend",
                                      amount: "${item.attend}",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                        tabindex: tab_index,
                                        url: item.notAttendUrl!,
                                        name: "Non-Attend",
                                      );
                                    },
                                    child: DashBoardItemButton(
                                      color_grid: [
                                        Color(0xffEF788D),
                                        Color(0xffF078A8),
                                      ],
                                      header: "Not Attend",
                                      amount: "${item.notAttend}",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      startDowload(
                                        tabindex: tab_index,
                                        url: item.tsTripsUrl!,
                                        name: "Trips",
                                      );
                                    },
                                    child: DashBoardItemButton(
                                      color_grid: [
                                        Color(0xff3AB370),
                                        Color(0xff6CC06B),
                                      ],
                                      header: "Trips",
                                      amount: "${item.tsTrips}",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      if (_dashboardVehicleModel == null)
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primary_color,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );

        // 🚉 transfer station main with all features
        Widget transfer_station_main = _dashboardTransferStationTabModel == null
            ? Container(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    // 4 grid
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: (2.8 / 1),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                      //physics:BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.0),
                      children: [
                        // zone container
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                .8),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Text(
                                          "Select Zone",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            ...new_zones!.data!.map(
                                              (e) => InkWell(
                                                child: DropdownMenuItem(
                                                  child: Text("${e.name}"),
                                                  onTap: () {},
                                                ),
                                                onTap: () {
                                                  print("Clicked");
                                                  _new_selected_zone = e;
                                                  _selected_circle = null;
                                                  Navigator.pop(c);
                                                  MProgressIndicator.show(
                                                      context);
                                                  value.getCirclesForVehicles(
                                                      _new_selected_zone);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  _new_selected_zone == null
                                      ? "Zones"
                                      : _new_selected_zone!.name ??
                                          "Zone Undefined",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffF24169),
                                  Color(0xffF4754C),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //Circle type
                        InkWell(
                          onTap: () {
                            if (value.circles == null) {
                              "Please Select Zone First".showSnackbar(context);
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListTile(
                                      title: Text(
                                        "Circle",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ...value.circles!.data!.map(
                                            (e) => InkWell(
                                              child: DropdownMenuItem(
                                                child: Text(
                                                  "${e.name!.camelCase}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onTap: () {},
                                              ),
                                              onTap: () {
                                                print("Clicked");
                                                _selected_circle = e;
                                                Navigator.pop(c);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.24,
                                  child: Text(
                                    _selected_circle == null
                                        ? "Circles"
                                        : _selected_circle!.name!.camelCase,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF80CBC4),
                                  Color(0xFF00796B),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //vehicle type
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Text(
                                          "Select Vehicle Type",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            ...value.vehicle_type!.data!.map(
                                              (e) => InkWell(
                                                child: DropdownMenuItem(
                                                  child: Text(
                                                    "${e.name!.camelCase}",
                                                  ),
                                                  onTap: () {},
                                                ),
                                                onTap: () {
                                                  print("Clicked");
                                                  _selected_vehicle = e;
                                                  Navigator.pop(c);
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.24,
                                  child: Text(
                                    _selected_vehicle == null
                                        ? "Vehicle Type"
                                        : _selected_vehicle!.name!.camelCase,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff6CC06B),
                                  Color(0xff3AB370),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Select Transfer Station
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListTile(
                                      title: Text(
                                        "Select Transfer Station",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ...value.transfer_station!.data!.map(
                                            (e) => InkWell(
                                              child: DropdownMenuItem(
                                                child: Text(
                                                  "${e.name!.camelCase}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onTap: () {},
                                              ),
                                              onTap: () {
                                                print("Clicked");
                                                _selected_transfer_station = e;
                                                Navigator.pop(c);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///
                                    // child: ListView(
                                    //   // physics: NeverScrollableScrollPhysics(),
                                    //   shrinkWrap: true,
                                    //   children: [
                                    //     Text(
                                    //       "Select Transfer Station",
                                    //       style: TextStyle(
                                    //           fontSize: 20,
                                    //           fontWeight: FontWeight.w600),
                                    //     ),
                                    //     SizedBox(
                                    //       height: 15,
                                    //     ),
                                    //     ListView(
                                    //       shrinkWrap: true,
                                    //       children: [
                                    //         ...value.transfer_station!.data!
                                    //             .map(
                                    //           (e) => InkWell(
                                    //             child: DropdownMenuItem(
                                    //               child: Text(
                                    //                 "${e.name!.camelCase}",
                                    //                 overflow:
                                    //                     TextOverflow.ellipsis,
                                    //               ),
                                    //               onTap: () {},
                                    //             ),
                                    //             onTap: () {
                                    //               print("Clicked");
                                    //               _selected_transfer_station =
                                    //                   e;
                                    //               Navigator.pop(c);
                                    //               setState(() {});
                                    //             },
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      width: constraints.maxWidth * 0.8,
                                      child: Text(
                                        _selected_transfer_station == null
                                            ? "Transfer Station"
                                            : _selected_transfer_station!
                                                .name!.camelCase,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff58B9EC),
                                  Color(0xff4065AC),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // date selection
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  content: Container(
                                    height: 350,
                                    width: MediaQuery.of(ctx).size.width * 0.8,
                                    color: Colors.white,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        SfDateRangePicker(
                                          onSelectionChanged: (s) {
                                            DateRangePickerSelectionChangedArgs
                                                dateargs = s;
                                            startDate =
                                                dateargs.value.startDate;
                                            endDate = dateargs.value.endDate;
                                            //   setState(() {});
                                          },
                                          maxDate: DateTime.now(),
                                          startRangeSelectionColor:
                                              Colors.green[500],
                                          endRangeSelectionColor:
                                              Colors.red[500],
                                          selectionColor: Colors.pink,

                                          // todayHighlightColor: Colors.pink,
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                        ),
                                        GradientButton(
                                          onclick: () {
                                            Navigator.pop(ctx);
                                            setState(() {});
                                            if (startDate == null ||
                                                endDate == null) {
                                              "Please choose Start Date and End Date"
                                                  .showSnackbar(context);
                                            }
                                          },
                                          title: "Done",
                                          height: 15,
                                          fontsize: 14,
                                          padding: 4,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                if (startDate == null || endDate == null)
                                  Text(
                                    "Select Date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                if (startDate != null && endDate != null)
                                  Text(
                                    startDate != null
                                        ? "Start Date : " +
                                            DateFormat.yMMMMd()
                                                .format(startDate!) +
                                            "\n" +
                                            "End Date : " +
                                            DateFormat.yMMMMd().format(
                                                endDate ?? DateTime.now())
                                        : "Select Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                SizedBox(width: 7),
                                // icon not display while date is avaiable
                                if (startDate == null)
                                  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.white,
                                    size: 25,
                                  )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff935498),
                                  Color(0xff6D58A3),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // download button
                        InkWell(
                          onTap: () {
                            _download_master_file();
                          },
                          child: Container(
                            width: 200,
                            height: 60,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  "Download",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(colors: main_color),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_dashboardTransferStationTabModel != null)
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: (2.0 / 1),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        //physics:BouncingScrollPhysics(),
                        padding: EdgeInsets.all(10.0),
                        children: [
                          // zone container
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Vehicle Count \n ${_dashboardTransferStationTabModel?.totalVehicles ?? 0}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffF24169),
                                  Color(0xffF4754C),
                                ],
                              ),
                            ),
                          ),
                          //vehicle type
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Trip Count \n ${_dashboardTransferStationTabModel?.trips ?? 0} ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff6CC06B),
                                  Color(0xff3AB370),
                                ],
                              ),
                            ),
                          ),
                          // garabage collection
                          Container(
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Row(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth * 0.8,
                                      child: Text(
                                        "Garbage Collection \n ${_dashboardTransferStationTabModel?.garbageCollection ?? 0}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff58B9EC),
                                  Color(0xff4065AC),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    // 💢 Multiple scroll with downloads
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: [
                          if (_dashboardTransferStationTabModel != null)
                            ..._dashboardTransferStationTabModel!.data!
                                .mapIndexed(
                              (item, index) => Column(
                                //  shrinkWrap: true,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 90,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            gradient: LinearGradient(
                                              colors: ++index % 2 == 0
                                                  ? [
                                                      Color(0xff58B9EC),
                                                      Color(0xff4065AC),
                                                    ]
                                                  : [
                                                      Color(0xff6CC06B),
                                                      Color(0xff3AB370),
                                                    ],
                                            ),
                                          ),
                                        ),
                                        Flex(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 5),
                                            Expanded(
                                              flex: 8,
                                              child: Center(
                                                child: Container(
                                                  child: Text(
                                                    "${index}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                            Expanded(
                                              flex: 14,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Center(
                                                  child: Text(
                                                    "${item.tsName ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                            Expanded(
                                              flex: 16,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Text(
                                                  "Vehicle Count \n ${item.vehiclesCount} ",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Text(
                                                  "Trip Count \n ${item.tripsCount} ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                            Expanded(
                                              flex: 19,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Text(
                                                  "Garbage Weight\n${item.garbageCollection} tons",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  startDowload(
                                                      tabindex: 2,
                                                      url: item.url!,
                                                      name: item.tsName!);
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    Icons.download,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5)
                                ],
                              ),
                            ),
                          if (_dashboardVehicleModel == null)
                            Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primary_color,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );

        // 🥩 Culvert station main with all features
        Widget culvert_tabs = _dashboardTransferStationTabModel == null
            ? Container(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    // 4 grid
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: (2.8 / 1),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                      //physics:BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.0),
                      children: [
                        // zone container
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Text(
                                          "Select Zone",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            ...new_zones!.data!.map(
                                              (e) => InkWell(
                                                child: DropdownMenuItem(
                                                  child: Text("${e.name}"),
                                                  onTap: () {},
                                                ),
                                                onTap: () async {
                                                  print("Clicked");
                                                  _new_selected_zone = e;
                                                  _selected_circle = null;
                                                  Navigator.pop(c);
                                                  MProgressIndicator.show(
                                                      context);
                                                  value.getCirclesForCulvert(
                                                      _new_selected_zone);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  _new_selected_zone == null
                                      ? "Zones"
                                      : _new_selected_zone!.name ??
                                          "Zone Undefined",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffF24169),
                                  Color(0xffF4754C),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //Circle type
                        InkWell(
                          onTap: () {
                            if (value.circles == null) {
                              "Please Select Zone First".showSnackbar(context);
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListTile(
                                      title: Text(
                                        "Circle",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ...value.circles!.data!.map(
                                            (e) => InkWell(
                                              child: DropdownMenuItem(
                                                child: Text(
                                                  "${e.name!.camelCase}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onTap: () {},
                                              ),
                                              onTap: () {
                                                print("Clicked");
                                                _selected_circle = e;
                                                Navigator.pop(c);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.24,
                                  child: Text(
                                    _selected_circle == null
                                        ? "Circles"
                                        : _selected_circle!.name!.camelCase,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff6CC06B),
                                  Color(0xff3AB370),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Select Status
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Text(
                                          "Select Status",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            ...["pending", "solved"].map(
                                              (e) => InkWell(
                                                child: DropdownMenuItem(
                                                  child: Text(
                                                    "${e.camelCase}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () {},
                                                ),
                                                onTap: () {
                                                  print("status clicked");
                                                  status = e;
                                                  Navigator.pop(c);
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      width: constraints.maxWidth * 0.8,
                                      child: Text(
                                        status == null
                                            ? "Select Status"
                                            : status!.camelCase,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff58B9EC),
                                  Color(0xff4065AC),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // date selection
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  content: Container(
                                    height: 350,
                                    width: MediaQuery.of(ctx).size.width * 0.8,
                                    color: Colors.white,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        SfDateRangePicker(
                                          onSelectionChanged: (s) {
                                            DateRangePickerSelectionChangedArgs
                                                dateargs = s;
                                            startDate =
                                                dateargs.value.startDate;
                                            endDate = dateargs.value.endDate;
                                            //   setState(() {});
                                          },
                                          maxDate: DateTime.now(),
                                          startRangeSelectionColor:
                                              Colors.green[500],
                                          endRangeSelectionColor:
                                              Colors.red[500],
                                          selectionColor: Colors.pink,

                                          // todayHighlightColor: Colors.pink,
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                        ),
                                        GradientButton(
                                          onclick: () {
                                            Navigator.pop(ctx);
                                            setState(() {});
                                            if (startDate == null ||
                                                endDate == null) {
                                              "Please choose Start Date and End Date"
                                                  .showSnackbar(context);
                                            }
                                          },
                                          title: "Done",
                                          height: 15,
                                          fontsize: 14,
                                          padding: 4,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                if (startDate == null || endDate == null)
                                  Text(
                                    "Select Date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                if (startDate != null && endDate != null)
                                  Text(
                                    startDate != null
                                        ? "Start Date : " +
                                            DateFormat.yMMMMd()
                                                .format(startDate!) +
                                            "\n" +
                                            "End Date : " +
                                            DateFormat.yMMMMd().format(
                                                endDate ?? DateTime.now())
                                        : "Select Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                SizedBox(width: 7),
                                // icon not display while date is avaiable
                                if (startDate == null)
                                  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.white,
                                    size: 25,
                                  )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff935498),
                                  Color(0xff6D58A3),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          _download_master_file();
                        },
                        child: Container(
                          width: 200,
                          height: 60,
                          child: Row(
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(width: 7),
                              Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(colors: main_color),
                          ),
                        ),
                      ),
                    ),
                    // 💢 Multiple scroll with downloads
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: [
                          if (_dashboardCulvertModel != null)
                            ..._dashboardCulvertModel!.data!.mapIndexed(
                              (item, index) => Column(
                                //  shrinkWrap: true,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    color: Colors.white,
                                    elevation: 12,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white70,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      height: 90,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          Flex(
                                            direction: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 5),
                                              Expanded(
                                                flex: 8,
                                                child: Center(
                                                  child: Container(
                                                    child: Text(
                                                      "${++index}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                flex: 14,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  child: Center(
                                                    child: Text(
                                                      "${item.name ?? ""}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                flex: 16,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Green",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.green[500],
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 3),
                                                      Text(
                                                        "${item.green} ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                flex: 15,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Orange",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.orange,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 3),
                                                      Text(
                                                        "${item.orange} ",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                flex: 15,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Red",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.red[500],
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 3),
                                                      Text(
                                                        "${item.red} ",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: InkWell(
                                                  onTap: () {
                                                    startDowload(
                                                      tabindex: 3,
                                                      url: item.url!,
                                                      name: item.name!,
                                                    );
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.download,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5)
                                ],
                              ),
                            ),
                          if (_dashboardVehicleModel == null)
                            Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primary_color,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );

        // 💡 here is playground
        return Column(
          children: [
            // top tab
            Globals.userData!.data!.departmentId == "1"
                ? master_tab
                : Globals.userData!.data!.departmentId == "4"
                    ? transfer_station_main
                    : SizedBox.shrink(),
            // tab  0️⃣ & 1️⃣  only for gvp bep and vehicles🚌
            if (tab_index == 0 || tab_index == 1)
              // Display only for departmentId's 1 & not equal to 4
              (Globals.userData!.data!.departmentId == "1" ||
                      Globals.userData!.data!.departmentId != "4")
                  ? vehicles_and_gvp_bep
                  : SizedBox.shrink(),
            // tab 2️⃣ station 🚉
            if (tab_index == 2)
              // Display only for departmentId's 1 & 4
              (Globals.userData!.data!.departmentId == "1" ||
                      Globals.userData!.data!.departmentId == "4")
                  ? transfer_station_main
                  : SizedBox.shrink(),
            // tab [3] culvert 🚉
            if (tab_index == 3)
              // Display only for departmentId's 1 & not equal to 4
              (Globals.userData!.data!.departmentId == "1" ||
                      Globals.userData!.data!.departmentId != "4")
                  ? culvert_tabs
                  : SizedBox.shrink(),
          ],
        );
      });
    else
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }

  // Vehicles list with download options
  Future<void> updateVehicleData() async {
    final provider = Provider.of<DashBoardProvider>(context, listen: false);

    String str = DateFormat("dd-MM-yyyy").format(DateTime.now());

    ApiResponse? response = await provider.getVehicesInfo(
        userid: Globals.userData!.data!.userId!, dateString: str);
    if (response!.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    _dashboardVehicleModel =
        DashboardVehicleModel.fromJson(response.completeResponse);
    setState(() {});
  }

  // GVP AND BEP list with download options
  Future<void> updateGvpAndBep() async {
    final provider = Provider.of<DashBoardProvider>(context, listen: false);

    String str = DateFormat("dd-MM-yyyy").format(DateTime.now());

    ApiResponse? response = await provider.getGepBepInfo(
        userid: Globals.userData!.data!.userId!, dateString: str);
    if (response!.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    _dashboardGvpBepModel =
        DashboardVehicleModel.fromJson(response.completeResponse);

    setState(() {});
  }

  // it load get transfer data
  Future<void> getTransferStationData() async {
    final provider = Provider.of<DashBoardProvider>(context, listen: false);
    String str = DateFormat("dd-MM-yyyy").format(DateTime.now());

    ApiResponse? response = await provider.getTransferStationTabData(
        userid: Globals.userData!.data!.userId!, dateString: str);
    if (response.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    _dashboardTransferStationTabModel =
        TransferStationTabModel.fromJson(response.completeResponse);
    setState(() {});
  }

  // This is used to download file as different tab child list items
  void startDowload(
      {required int tabindex, required String url, required String name}) {
    String filetype = "";
    if (tab_index == 0) {
      filetype = "Vehicle";
    } else if (tab_index == 1) {
      filetype = "GVP-BEP";
    } else if (tab_index == 2) {
      filetype = "Transfer-Station";
    } else if (tab_index == 3) {
      filetype = "Culvert-Issue";
    }

    DashBoardProvider.getReference(context).downloadFile(
        context: context,
        filename:
            "${filetype}-${name.camelCase}-${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
        url: url);
  }

  // this is used to download view download action.
  void _download_master_file() async {
    final value = DashBoardProvider.getReference(context);

    if (this._new_selected_zone == null ||
        this.startDate == null ||
        this.endDate == null) {
      "Please Select all options before download".showSnackbar(context);
      return;
    }

    if (this._selected_vehicle == null &&
        (tab_index == 2 || tab_index == 1 || tab_index == 0)) {
      "Selected Vehicle required".showSnackbar(context);
      return;
    }

    if (this._selected_transfer_station == null && tab_index == 2) {
      "Transfer Station required".showSnackbar(context);
      return;
    }

    if (this._selected_circle == null && tab_index == 3) {
      "Selected Circle".showSnackbar(context);
      return;
    }
    if (this.status == null && tab_index == 3) {
      "Status Required".showSnackbar(context);
      return;
    }

    if (tab_index == 0 && Globals.userData!.data!.departmentId == "1") {
      // execute only when index = 0 & departmentId = 1
      await DownloadViewScreenDashboard(
        startDate: startDate,
        endDate: endDate,
        selected_vehicle: _selected_vehicle,
        selected_zone: _new_selected_zone,
        selected_circle: _selected_circle,
      ).push(context);
      _resetDashBoard(); // see reset data here
    } else if (tab_index == 0 && Globals.userData!.data!.departmentId == "4") {
      // execute only when index = 0 & departmentId = 4
      await value.downloadMasterFile(
          context: context,
          startDate: startDate,
          endDate: endDate,
          selected_zone: _new_selected_zone,
          selected_circle: _selected_circle,
          selected_vehicle: _selected_vehicle,
          selected_transfer_station: _selected_transfer_station,
          filename: 'TRANSFER-STATION-MASTER',
          operation: downloadType.transfer_station);
      _resetDashBoard(); // see reset data here
    } else if (tab_index == 1) {
      // execute only when index = 1
      await value.downloadMasterFile(
          context: context,
          startDate: startDate,
          endDate: endDate,
          selected_zone: _new_selected_zone,
          selected_circle: _selected_circle,
          selected_vehicle: _selected_vehicle,
          selected_transfer_station: _selected_transfer_station,
          filename: 'GVP-BEP-MASTER',
          operation: downloadType.gvp_bep);
      _resetDashBoard(); // see reset data here
    } else if (tab_index == 2) {
      // execute only when index = 2
      await value.downloadMasterFile(
          context: context,
          startDate: startDate,
          endDate: endDate,
          selected_zone: _new_selected_zone,
          selected_circle: _selected_circle,
          selected_vehicle: _selected_vehicle,
          selected_transfer_station: _selected_transfer_station,
          filename: 'TRANSFER-STATION-MASTER',
          operation: downloadType.transfer_station);
      _resetDashBoard(); // see reset data here
    } else if (tab_index == 3) {
      // execute only when index = 3
      await value.downloadMasterFile(
          context: context,
          startDate: startDate,
          endDate: endDate,
          selected_zone: _new_selected_zone,
          selected_circle: _selected_circle,
          selected_transfer_station: _selected_transfer_station,
          status: status,
          filename: 'CULVERT-MASTER',
          operation: downloadType.culvert);
      _resetDashBoard(); // see reset data here
    }
  }

  // this is used to view culvert all issues action.
  Future<void> updateCulvert() async {
    final provider = Provider.of<DashBoardProvider>(context, listen: false);

    ApiResponse? response = await provider.getCulvertDashBoard();
    if (response.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    _dashboardCulvertModel =
        CulvertDashBoardModel.fromJson(response.completeResponse);

    setState(() {});
  }
}
