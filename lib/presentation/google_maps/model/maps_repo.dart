import 'package:flutter/cupertino.dart';
import '../helpers/user_current_location.dart';
import 'location_model.dart';

class MapsRepo {
  Future<LocationModel> getUserCurrentLocation() async {
    try {
      LocationModel currentLocation =
          await UserCurrentLocation().getCurrentLocation();
      return currentLocation;
    } catch (error) {
      throw FlutterError(error.toString());
    }
  }
}
