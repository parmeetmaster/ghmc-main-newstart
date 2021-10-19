import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/model/google_maps_model.dart';
import 'package:ghmc/util/location.dart';
import 'package:location/location.dart';

import 'utils.dart';

import 'package:ghmc/util/m_progress_indicator.dart';

class GeoHolder {
  String? statename;
  String? pincode;
  GoogleMapsModel? fulldata;
  LocationData? position;
}

/*This class used to get currunt location adderess*/
class GeoUtils {
  Future<GoogleMapsModel?>? getLocationDetails(LocationData position) async {
    Response response = await Dio().get(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${google_place_api_key}");
    if (response.statusCode == 200) {
      return GoogleMapsModel.fromJson(response.data);
    }
    return null;
  }

  Future<GeoHolder?> getGeoDatafromLocation(
      LocationData? position, BuildContext context) async {
    //MProgressIndicator.show(context);
    GoogleMapsModel? model = await getLocationDetails(position!);
    GeoHolder holder = new GeoHolder();
    holder.fulldata = model!;
    if (model == null) {
      "Unable to get location details".showSnackbar(context);
      return null;
    }

    for (AddressComponent addressComponent
        in model.results![0].addressComponents!) {
      addressComponent.types!.forEach((element) {
        if (element.contains("postal_code")) {
          holder.pincode = addressComponent.longName;
          //   this.zip_code.text = addressComponent.longName;
        } else if (element.contains("administrative_area_level_2")) {
          //this.city.text = addressComponent.longName;
        } else if (element.contains("administrative_area_level_1")) {
          holder.statename = addressComponent.longName;
        }
      });
    }

    MProgressIndicator.hide();
    holder.position = position;
    return holder;
  }

  Future<String?> getStateName(BuildContext context) async {
    LocationData? locationData = await CustomLocation().getLocation();
    if (locationData == null || locationData.latitude!.isNaN) {
      "Unable to take longitude and latitude".showSnackbar(context);
      return null;
    }
    return await getGeoDatafromLocation(locationData, context).then((value) {
      return value!.statename;
    });
  }
}
