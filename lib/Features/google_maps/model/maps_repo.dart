import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/location/user_current_location.dart';
import 'location_model.dart';

class MapsRepo {
  Future<LocationModel> getUserCurrentLocation() async {
    try {
      LocationModel currentLocation =
          await UserLocationService().getCurrentLocation();
      return currentLocation;
    } catch (error) {
      if (error is PlatformException) {
        throw FlutterError(error.message!);
      }
      throw FlutterError('Something Went Wrong');
    }
  }
}
