import 'package:flutter/material.dart';
import 'package:ghmc/screens/gvp_bep/googleMapScreen.dart';
import 'package:location/location.dart';

class MapContainer extends StatefulWidget {
  Function(LocationData)? locationData;

  MapContainer({Key? key, this.locationData}) : super(key: key);

  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  var locationCredentials = '';
  bool mapData = false;

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
        child: mapData == true ? _mapdata(context) : _mapEmpty(context),
      ),
    );

    //   return mapData == true ? _mapdata(context) : _mapEmpty(context);
  }

  Widget _mapEmpty(BuildContext context) {
    return Center(
        child: FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () async {
        LocationData? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GoogleMapScreen(),
          ),
        );
        if (result!.longitude != null) {
          mapData = true;
        }

        setState(() {
          if (widget.locationData != null) widget.locationData!(result);

          mapData = true;
          locationCredentials =
              "Longitude : ${result.longitude} Latitude : ${result.latitude}";
        });
        // GoogleMapScreen();
        // getCurrentLocation();
      },
      child: Image.asset(
        "assets/images/location.png",
        color: Colors.white,
        fit: BoxFit.fitHeight,
      ),
    ));
  }

  Widget _mapdata(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green[400],
            onPressed: () {},
            child: Image.asset(
              "assets/images/location.png",
              color: Colors.white,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text('$locationCredentials'),
          ),
        ],
      ),
    );
  }
}
