import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../Features/google_maps/model/location_model.dart';

class UserCurrentLocation {
  Future<LocationModel> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw PlatformException(
          code: "", message: AppStrings.locationDisabled.tr());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw PlatformException(
            code: "", message: AppStrings.locationDenied.tr());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw PlatformException(
          code: "", message: AppStrings.locationDeniedLong.tr());
    }

    Position currentLocation = await Geolocator.getCurrentPosition();

    // final coordinates =
    //     Coordinates(currentLocation.latitude, currentLocation.longitude);
    // var addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print(
    //     ' ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    LocationModel locationModel = LocationModel(
      // locationName: first.addressLine!,
      locationName: "",
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
    return locationModel;
  }
}
