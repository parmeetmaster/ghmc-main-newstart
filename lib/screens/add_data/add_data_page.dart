import 'package:flutter/material.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/screens/add_transfer_station/add_transferstation_page.dart';
import 'package:ghmc/screens/add_vehicle/add_vehicle_page.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/widget/card_seperate_row.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {
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
              "Add Data",
            ),
            /*    IconButton(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 35,
                ),
                onPressed: () {})*/
          ],
        ),
      ),
      body: ListView(
        children: [
          ...Globals.userData!.data!.access!.map((element) => Center(
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
                        CardSeperateRow("LandMark", element.landmarks),
                        CardSeperateRow("Ward", element.ward),
                        CardSeperateRow("Circle", element.circle),
                        CardSeperateRow("Zone", element.zone),
                        //  CardSeperateRow("City",""),
                        SizedBox(
                          height: 10,
                        ),
                        //see if user have authority 3
                        ...element.geoTagButtons!.map((val) {
                          print(val.id);
                        //  if (val.id == "3")
                          if (val.id == "611ae83fc574390cf4aafb01")
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: FlatButton(
                                    height: 30,
                                    minWidth: 200,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                (AddVehiclePage(element)),
                                          ));
                                    },
                                    child: Text(
                                      'Add Vehicle',
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
                            );
                          else
                            return Container(
                              height: 0,
                              width: 0,
                            );
                        }),
                        //see if user have authority 4
                        ...element.geoTagButtons!.map((val) {
                          if (val.id == "4")
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: FlatButton(
                                    height: 30,
                                    minWidth: 200,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddTransferStation(),
                                          ));
                                    },
                                    child: Text(
                                      'Add Transfer Station',
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
                            );
                          else
                            return Container(
                              height: 0,
                              width: 0,
                            );
                        })
                      ],
                    ),
                  ),
                ),
              ))),
        ],
      ),
    );
  }
}
