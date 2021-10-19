import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghmc/screens/gvp_bep/googleMapScreen.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:location/location.dart';

class CameraContainer extends StatefulWidget {
  Function(List<File>)? cameraData;

  CameraContainer({Key? key, this.cameraData}) : super(key: key);

  @override
  _CameraContainerState createState() => _CameraContainerState();
}

class _CameraContainerState extends State<CameraContainer> {
  var locationCredentials = '';
  bool mapData = false;
  List<File>? files;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.80,
        // child: IconButton(
        //   icon: Icon(Icons.map),
        //   onPressed: getCurrentLocation,
        // ),
        child: files!=null ? _mapdata(context) : _mapEmpty(context),
      ),
    );

    //   return mapData == true ? _mapdata(context) : _mapEmpty(context);
  }

  Widget _mapEmpty(BuildContext context) {
    return Center(
        child: FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () async {
        files = await FilePick().pickFiles();
        files!.forEach((e) => print("element load ${e.path}"));
        setState(() {
          widget.cameraData!(files!);
        });
      },
      child: Icon(
        Icons.camera,
        color: Colors.white,
        size: 40,
      ),
    ));
  }

  Widget _mapdata(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () async {
                files = await FilePick().pickFiles();
                files!.forEach((e) => print("element load ${e.path}"));
                setState(() {
                  widget.cameraData!(files!);
                });
              },
              child: Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 40,
                  ),

            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('${files!.length} Image Selected'),
            ),
          ],
        ));
  }


}
