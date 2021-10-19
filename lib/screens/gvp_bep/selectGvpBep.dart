import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/provider/add_gvp_bep_provider/addGvpBepProvider.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/container/map_container.dart';
import 'package:ghmc/util/utils.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:provider/provider.dart';

class SelectGvpBepScreen extends StatefulWidget {
  const SelectGvpBepScreen({Key? key}) : super(key: key);

  @override
  _SelectGvpBepScreenState createState() => _SelectGvpBepScreenState();
}

class _SelectGvpBepScreenState extends State<SelectGvpBepScreen> {
  List<String> items = ['GVP', 'BEP'];
  Access? selected_zone;
  Access? selected_ward;
  Access? selected_circle;
  String? selected_type;
  String? formatted_address;
  GeoHolder? geoData;

  String itemValue = 'GVP';
  List<Access> avaiable_zone_list = [];
  List<Access> avaiable_circle_list = [];
  List<String> gvp_bep = ['GVP', 'BEP'];

  // formKey for form validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingController

  final TextEditingController _landMarkController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  double textsize = 14;

  @override
  void initState() {
    super.initState();
    setUpNonDuplicateZones();
    setUpNonDuplicateCircles();
  }

  // this function remove duplicate zones of access objects
  setUpNonDuplicateZones() {
    Set<String?> zones = new Set(); //this is set of unique values
    Globals.userData!.data!.access!.forEach((e) => zones.add(e.zoneId));
    zones.forEach((zoneid) {
      avaiable_zone_list.add(Globals.userData!.data!.access!
          .where((element) => element.zoneId == zoneid)
          .first);
    });
    print(avaiable_zone_list.length);
    setState(() {});
  }

  // this function remove duplicate zones of access objects
  setUpNonDuplicateCircles() {
    Set<String?> circles = new Set(); //this is set of unique values
    Globals.userData!.data!.access!.forEach((e) => circles.add(e.circleId));
    circles.forEach((circleid) {
      avaiable_circle_list.add(Globals.userData!.data!.access!
          .where((element) => element.circleId == circleid)
          .first);
    });
    print(avaiable_zone_list.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Select GVP /BEP"),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 30.0,
              ),
              //gvp/bep
              _getDropDownParent(
                child: DropdownButton(
                  isExpanded: true,
                  //value: selectedOwnerType,
                  onChanged: (value) {
                    selected_type = value as String;
                    setState(() {});
                  },
                  items: gvp_bep
                      .toList()
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text("${e}"),
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
                      selected_type == null
                          ? "Select GVP/BEP"
                          : "${selected_type}",
                      style: TextStyle(color: Colors.black, fontSize: textsize),
                    ),
                  ),
                  onTap: () {},
                ),
              ), //end circle

              SizedBox(
                height: 20.0,
              ),

              MapContainer(
                locationData: (s) async {
                  geoData = await GeoUtils().getGeoDatafromLocation(
                      await CustomLocation().getLocation(), context);
                  formatted_address = geoData!.formattedAddress;
                },
              ),

              SizedBox(
                height: 20.0,
              ),

              //zone
              _getDropDownParent(
                  child: DropdownButton(
                isExpanded: true,
                //value: selectedOwnerType,
                onChanged: (value) {
                  selected_zone = value as Access?;
                  setState(() {});
                },
                items: avaiable_zone_list
                    .toList()
                    .map((e) => DropdownMenuItem<Access>(
                          value: e,
                          child: Text("${e.zone}"),
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
                    selected_zone == null
                        ? "Select Zone"
                        : "${selected_zone!.zone}",
                    style: TextStyle(color: Colors.black, fontSize: textsize),
                  ),
                ),
                onTap: () {},
              )), //end zone

              //circle
              _getDropDownParent(
                  child: DropdownButton(
                isExpanded: true,
                //value: selectedOwnerType,
                onChanged: (value) {
                  selected_circle = value as Access?;
                  setState(() {});
                },
                items: avaiable_circle_list
                    .toList()
                    .map((e) => DropdownMenuItem<Access>(
                          value: e,
                          child: Text("${e.circle}"),
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
                    selected_circle == null
                        ? "Select Circle"
                        : "${selected_circle!.circle}",
                    style: TextStyle(color: Colors.black, fontSize: textsize),
                  ),
                ),
                onTap: () {},
              )), //end circle

              //ward
              _getDropDownParent(
                  child: DropdownButton(
                isExpanded: true,
                //value: selectedOwnerType,
                onChanged: (value) {
                  selected_ward = value as Access?;
                  setState(() {});
                },
                items: Globals.userData!.data!.access!
                    .toList()
                    .map((e) => DropdownMenuItem<Access>(
                          value: e,
                          child: Text("${e.ward}"),
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
                    selected_ward == null //change here
                        ? "Select Ward"
                        : "${selected_ward!.ward}",
                    style: TextStyle(color: Colors.black, fontSize: textsize),
                  ),
                ),
                onTap: () {},
              )), //end ward
              SizedBox(
                height: 10,
              ),
              // landmark
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                  controller: _landMarkController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusColor: Colors.black45,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      border: OutlineInputBorder(),
                      labelText: 'Land Mark',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              //area
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                  controller: _areaController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusColor: Colors.black45,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      border: OutlineInputBorder(),
                      labelText: ' Area/ Colony',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: GradientButton(
                  title: "Submit",
                  onclick: () async {
                    MProgressIndicator.show(context);
                    if (this.formatted_address == null) {
                      "Please Select Location on map".showSnackbar(context);
                      return;
                    }
                    if (this.selected_type == null) {
                      "Please Select Gvp and BEP.".showSnackbar(context);
                      return;
                    }
                    if (this.selected_ward == null) {
                      "Please Select ward".showSnackbar(context);
                      return;
                    }
                    if (this.selected_circle == null) {
                      "Please Select Circle".showSnackbar(context);
                      return;
                    }
                    if (this.selected_zone == null) {
                      "Please Select Zone".showSnackbar(context);
                      return;
                    }
                    if (this.selected_circle == null) {
                      "Please Select Circle".showSnackbar(context);
                      return;
                    }
                    if (this._landMarkController.text.isEmpty) {
                      "Landmark is required.".showSnackbar(context);
                      return;
                    }
                    if (this._areaController.text.isEmpty) {
                      "Area is required.".showSnackbar(context);
                      return;
                    }
                    if (this.geoData == null) {
                      "Please fill map coordinates".showSnackbar(context);
                      return;
                    }

                    final provider =
                        Provider.of<GvpBepProvider>(context, listen: false);
                    ApiResponse response = await provider.submit_Gvp_Bep(
                        geo_data: geoData,
                        landmark_controller: _landMarkController,
                        formatted_address: this.formatted_address,
                        selected_type: this.selected_type,
                        selected_ward: this.selected_ward,
                        selected_circle: this.selected_circle,
                        area: this._areaController,
                        selected_zone: this.selected_zone);
                    if (response.status != 200) {
                      SingleButtonDialog(
                        message: response.message,
                        imageurl: "assets/images/cancel.png",
                        type: Imagetype.png,
                        okbtntext: 'Please login again',
                        onOk: (c) async {
                          await LoginProvider.getInstance(context)
                              .logout(context);
                        },
                      ).pushDialog(context);
                    } else if (response.status == 200)
                      SingleButtonDialog(
                        message: response.message,
                        imageurl: "assets/check.svg",
                        onOk: (c) {
                          DashBoardScreen().pushAndPopTillFirst(context);
                          Navigator.pop(context);
                        },
                      ).pushDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // this return container for dropdown button
  _getDropDownParent({Widget? child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black45,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
