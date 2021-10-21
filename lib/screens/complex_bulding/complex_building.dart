import 'package:flutter/material.dart';
import 'package:ghmc/provider/complex_building/complex_building.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/util/utils.dart';
import 'package:ghmc/widget/card_seperate_row.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:provider/provider.dart';

import 'circle_user_access_complex.dart';
import 'complex_building_add.dart';

/// pending to show things here api is not ready
class ComplexBuilding extends StatefulWidget {
  const ComplexBuilding({Key? key}) : super(key: key);

  @override
  _ComplexBuildingState createState() => _ComplexBuildingState();
}

class _ComplexBuildingState extends State<ComplexBuilding> {
  @override
  void initState() {
    Provider.of<ComplexBuildingProvider>(context, listen: false)
        .loadComplexBuilding();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComplexBuildingProvider>(context);
    return Scaffold(
      appBar: FAppBar.getAppBarWithPlus(
          title: "Complex Building",
          onclick: () {
            ComplexBuildingAdd().push(context);
          }),
      body: ListView(
        children: [
          if (provider.circleComplexAccessModel== null)
        Container(
            height: MediaQuery.of(context).size.height-30,
            child: Center(child: CircularProgressIndicator(color: Colors.pink,),))
          else
            ...provider.circleComplexAccessModel!.data!.map((e) => Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CardSeperateRow("Complex Name", e.name),
                          CardSeperateRow("Address", e.address),
                          CardSeperateRow("LandMark", e.landmark),
                          CardSeperateRow("Area", e.area),
                          CardSeperateRow("Ward", e.wardName),
                          CardSeperateRow("Circle", e.circle),
                          CardSeperateRow("Zone", e.zone),
                          //  CardSeperateRow("City",""),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: FlatButton(
                                  height: 30,
                                  minWidth: 200,
                                  onPressed: () {
                                    CicrclueUserAccessComplex(e.id!).push(context);
                                  },
                                  child: Text(
                                    'Add Complex',
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
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )))


        ],
      ),
    );
  }
}
