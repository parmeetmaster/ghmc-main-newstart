import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/gep_bep/gep_bep_list_model.dart';
import 'package:ghmc/provider/add_gvp_bep_provider/addGvpBepProvider.dart';
import 'package:ghmc/screens/gvp_bep/selectGvpBep.dart';
import 'package:provider/provider.dart';

import 'add_gvp_bvp.dart';
import 'package:ghmc/util/utils.dart';

class GvpBepScreen extends StatefulWidget {
  const GvpBepScreen({Key? key}) : super(key: key);

  @override
  _GvpBepScreenState createState() => _GvpBepScreenState();
}

class _GvpBepScreenState extends State<GvpBepScreen> {
  double gap = 10;
  GepBepListModel? gepBepListModel;

  @override
  void initState() {
    super.initState();
    _load_Gep_Bep();
  }

  @override
  Widget build(BuildContext context) {
    // this have grey shade problem
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFAD1457),
                  Color(0xFFAD801D9E),
                ]),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GVP / BEP",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: 2,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectGvpBepScreen(),
                    ),
                  );
                })
          ],
        ),
      ),
      body: gepBepListModel != null
          ? ListView(
              shrinkWrap: true,
              children: gepBepListModel!.data!
                  .map(
                    (element) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: gap,
                              ),
                              _getRowVehicleDetails(
                                key: "Type",
                                value: "${element.type}",
                              ),
                              SizedBox(
                                height: gap,
                              ),
                              _getRowVehicleDetails(
                                key: "Landmark",
                                value: "${element.landmark}",
                              ),
                              SizedBox(
                                height: gap,
                              ),
                              _getRowVehicleDetails(
                                key: "Area/Colony ",
                                value: "${element.area}",
                              ),
                              SizedBox(
                                height: gap,
                              ),
                              _getRowVehicleDetails(
                                key: "Ward",
                                value: "${element.wardName}",
                              ),
                              SizedBox(
                                height: gap,
                              ),
                              _getRowVehicleDetails(
                                key: "Circle",
                                value: "${element.circle}",
                              ),
                              SizedBox(
                                height: gap,
                              ),
                              _getRowVehicleDetails(
                                key: "Zone",
                                value: "${element.zone}",
                              ),
                              SizedBox(
                                height: gap,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: FlatButton(
                                      height: 40,
                                      minWidth: 300,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddGvpBepScreen(
                                              data: element,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Add GVP/BVP',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFAD1457),
                                          Color(0xFFAD801D9E)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  // widgets
  _getRowVehicleDetails({
    String key = "",
    String value = "",
  }) {
    int flexLeft = 4;
    int flexRight = 5;
    TextStyle style = TextStyle(
      fontSize: 16,
    );
    return Row(
      children: [
        Expanded(
          flex: flexLeft,
          child: Text(
            "$key",
            style: style,
          ),
        ),
        SizedBox(
          width: 15,
          child: Text(":"),
        ),
        Expanded(
          flex: flexRight,
          child: Text(
            "$value",
            style: style,
          ),
        ),
      ],
    );
  }

  _getPercentageContainer(String percent) {
    return Container(
      height: 40,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            percent,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFFF5277),
            Color(0xFFF06292),
            Color(0xFF9C27B0),
          ],
        ),
      ),
    );
  }

  void _load_Gep_Bep() async {
    final provider = Provider.of<GvpBepProvider>(context, listen: false);

    ApiResponse? response = await provider.getGepBepList();

    if (response!.status == 200)
      gepBepListModel = GepBepListModel.fromJson(response.completeResponse);
    else
      response.message!.showSnackbar(context);

    setState(() {});
  }
}
