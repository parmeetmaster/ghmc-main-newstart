import 'dart:core';
// import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/maps_model/locationsMap_model.dart';
import 'package:ghmc/provider/maps_provider/maps_provider.dart';
import 'package:ghmc/util/location.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LocationData? position;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  MapLocations? data;

  Future<void> _getMapLocations() async {
    final mapLocationProvider =
        Provider.of<MapLocationProvider>(context, listen: false);
    ApiResponse? resp = await mapLocationProvider.vehiclesLocations();

    late GoogleMapController mapController;
    LocationData? position;
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    if (resp!.status == 200) {
      data = MapLocations.fromJson(resp.completeResponse);
    } else {
      Text('${resp.message}');
    }
    setState(() {});
  }

  @override
  void initState() {
    setUpLocation();
    Future.wait([_getMapLocations()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.green[700],
      ),
      body: (data != null)
          ? _buildBody(context)
          : Center(child: CircularProgressIndicator()),
    );
  }

  CameraPosition camera_location = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(17.385, 78.4867),
    zoom: 18.151926040649414,
  );

  Widget _buildBody(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: camera_location,
      myLocationEnabled: true,
      onMapCreated: _onMapCreated,
      markers: Set.from(
        Iterable.generate(
          data!.data!.length,
          (index) {
            double longitude = double.parse('${data!.data![index].longitude}');
            double latitude = double.parse('${data!.data![index].latitude}');
            return Marker(
              icon: data!.data![index].color == 'Orange'
                  ? BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange)
                  : data!.data![index].color == 'Red'
                      ? BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed)
                      : data!.data![index].color == 'Yellow'
                          ? BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueYellow)
                          : data!.data![index].color == 'Blue'
                              ? BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue)
                              : data!.data![index].color == 'Green'
                                  ? BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueGreen)
                                  : BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRose),
              markerId: MarkerId(data!.data![index].id!),
              position: LatLng(
                latitude,
                longitude,
              ),
              infoWindow: InfoWindow(
                title: data!.data![index].id,
                snippet: data!.data![index].type!.toUpperCase(),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Vehicle Details',
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _alertBoxBody(
                            context,
                            'Type',
                            '${data!.data![index].type}'.toUpperCase(),
                          ),
                          SizedBox(height: 8.0),
                          _alertBoxBody(
                            context,
                            'Landmark',
                            '${data!.data![index].landmark}',
                          ),
                          SizedBox(height: 8.0),
                          _alertBoxBody(
                            context,
                            'Area',
                            '${data!.data![index].area}',
                          ),
                          SizedBox(height: 8.0),
                          _alertBoxBody(
                            context,
                            'Trips',
                            '${data!.data![index].trips}',
                          ),
                          SizedBox(height: 8.0),
                          data!.data![index].trips != '0'
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  child: data!.data![index].image != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Image.network(
                                              '${data!.data![index].image}'),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator()),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                  // AwesomeDialog(
                  //   context: context,
                  //   dialogType: DialogType.SUCCES,
                  //   animType: AnimType.BOTTOMSLIDE,
                  //   title: 'Vehicle Details',
                  //   body: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       _alertBoxBody(
                  //         context,
                  //         'Type',
                  //         '${data!.data![index].type}',
                  //       ),
                  //       SizedBox(height: 8.0),
                  //       _alertBoxBody(
                  //         context,
                  //         'Area',
                  //         '${data!.data![index].area}',
                  //       ),
                  //       SizedBox(height: 8.0),
                  //       _alertBoxBody(
                  //         context,
                  //         'Landmark',
                  //         '${data!.data![index].landmark}',
                  //       ),
                  //       SizedBox(height: 8.0),
                  //       _alertBoxBody(
                  //         context,
                  //         'Trips',
                  //         '${data!.data![index].trips}',
                  //       ),
                  //       SizedBox(height: 8.0),
                  //       data!.data![index].trips != '0'
                  //           ? Container(
                  //               height:
                  //                   MediaQuery.of(context).size.height * 0.40,
                  //               child: data!.data![index].image != null
                  //                   ? Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8.0),
                  //                       child: Image.network(
                  //                           '${data!.data![index].image}'),
                  //                     )
                  //                   : Center(
                  //                       child: CircularProgressIndicator()),
                  //             )
                  //           : SizedBox.shrink(),
                  //     ],
                  //   ),
                  // )..show();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void setUpLocation() async {
    position = await CustomLocation().getLocation();
    if (position!.latitude!.isNaN == false) {
      camera_location = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(position!.latitude!, position!.longitude!),
          zoom: 40.151926040649414);
    }
    setState(() {});
  }

  Widget _alertBoxBody(
    BuildContext context,
    String key,
    String value,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.23,
            child: Text(key),
          ),
          Text(': '),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
