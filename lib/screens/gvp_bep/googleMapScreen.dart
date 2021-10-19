import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/provider/location_provider/location_provider.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  LocationData? position;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check your location"),
        backgroundColor: Colors.green[700],
      ),
      body: googleMap(context),
    );
  }

  CameraPosition camera_location = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(20.5937, 78.9629),
      zoom: 10.151926040649414);

  Widget googleMap(BuildContext context) {
    if (position != null) {
      return Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: camera_location,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,

          ),
          Positioned(
              left: 120.0,
              bottom: 20.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: FlatButton(
                      height: 40,
                      minWidth: 100,
                      onPressed: () async {
                        MProgressIndicator.show(context);
                        GeoHolder? data = await GeoUtils()
                            .getGeoDatafromLocation(
                                await CustomLocation().getLocation(), context);
                        MProgressIndicator.hide();
                        await showDialog(
                          context: context,
                          builder: (ctx) => new AlertDialog(
                            title: Text('Your location'),
                            content: Text(
                                '${data!.fulldata!.results!.first.formattedAddress}'),
                            actions: <Widget>[
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("Done"),
                                ),
                              ),
                            ],
                          ),
                        );
                        Navigator.pop(context, position);
                      },
                      child: Text(
                        'Add Location',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              )),
        ],
      );
    } else
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
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
}
