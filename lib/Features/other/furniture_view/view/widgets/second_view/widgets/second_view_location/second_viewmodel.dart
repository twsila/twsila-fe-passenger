import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_for_you/Features/other/furniture_view/models/furniture_model.dart';

import '../../../../../../../../app/constants.dart';
import '../../../../../../../../core/utils/resources/strings_manager.dart';

class SecondViewModel {
  String? distance;

  checkAndCalculateDistance(FurnitureModel furnitureModel) async {
    if (furnitureModel.pickupLocationLatitude != null &&
        furnitureModel.pickupLocationLongitude != null &&
        furnitureModel.destinationLocationLatitude != null &&
        furnitureModel.destinationLocationLongitude != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      List<LatLng> polylineCoordinates = [];
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Platform.isIOS
            ? Constants.GOOGLE_API_KEY_IOS
            : Constants.GOOGLE_API_KEY_ANDROID,
        PointLatLng(
          double.parse(furnitureModel.pickupLocationLatitude!),
          double.parse(furnitureModel.pickupLocationLongitude!),
        ),
        PointLatLng(double.parse(furnitureModel.destinationLocationLatitude!),
            double.parse(furnitureModel.destinationLocationLongitude!)),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _calculateDistance(polylineCoordinates);
    } else {
      distance = null;
    }
  }

  _calculateDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    distance =
        '${AppStrings.distance.tr()}${totalDistance.toStringAsFixed(2)} ${AppStrings.km.tr()}';
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
