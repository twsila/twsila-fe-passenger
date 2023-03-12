import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/presentation/google_maps/helpers/set_result.dart';
import 'package:taxi_for_you/presentation/google_maps/helpers/show_all_markers.dart';

import '../model/location_model.dart';

class MapProvider with ChangeNotifier {
  Results results = Results();
  GoogleMapController? controller;
  MarkerId sourceMarkerId = const MarkerId('source_location');
  MarkerId destinationMarkerId = const MarkerId('destination_location');

  //Locations
  LocationModel? currentLocation;
  LocationModel? sourceLocation;
  LocationModel? destinationLocation;
  List<String> countries = ['eg'];
  String? distance;

  //Marker
  final Set<Marker> markers = {};

  //PolyLines
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  //Handle Markers
  addMarker(Marker marker) {
    markers.add(marker);
    notifyListeners();
  }

  removeMarker(MarkerId markerId) {
    markers.removeWhere((element) => element.markerId == markerId);
    notifyListeners();
  }

  setCountry(String country) {
    countries = [country];
    notifyListeners();
  }

  //Handle Map
  animateCamera(LatLng latLng) async {
    if (controller == null) return;
    controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 16.5,
    )));
  }

  setSourceLocation(LocationModel? sourceLocation) {
    this.sourceLocation = sourceLocation;
    if (sourceLocation == null) {
      results.sourceLocation = null;
      removeMarker(sourceMarkerId);
      resetPolyPoints();
      return;
    }
    LatLng latLng = LatLng(sourceLocation.latitude, sourceLocation.longitude);
    if (destinationLocation == null) animateCamera(latLng);
    addMarker(
      Marker(markerId: sourceMarkerId, position: latLng),
    );
    getPolyline();

    results.sourceLocation = sourceLocation.locationName;
  }

  setDestinationLocation(LocationModel? destinationLocation) {
    this.destinationLocation = destinationLocation;
    if (destinationLocation == null) {
      results.destinationLocation = null;
      removeMarker(destinationMarkerId);
      resetPolyPoints();
      return;
    }
    LatLng latLng =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);
    if (sourceLocation == null) animateCamera(latLng);

    addMarker(
      Marker(markerId: destinationMarkerId, position: latLng),
    );
    getPolyline();

    results.destinationLocation = destinationLocation.locationName;
  }

  //Handle Polylines
  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 2,
    );
    polylines[id] = polyline;
    notifyListeners();
  }

  getPolyline() async {
    if (controller == null ||
        sourceLocation == null ||
        destinationLocation == null) return;
    resetPolyPoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.GOOGLE_API_KEY,
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(
          destinationLocation!.latitude, destinationLocation!.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    addPolyLine();
    Future.delayed(
        const Duration(milliseconds: 200),
        () => controller!.animateCamera(CameraUpdate.newLatLngBounds(
            MapUtils.boundsFromLatLngList(
                markers.map((loc) => loc.position).toList()),
            1)));

    calculateDistance(polylineCoordinates);
  }

  resetPolyPoints() {
    polylineCoordinates.clear();
    polylines.clear();
    distance = null;
    notifyListeners();
  }

  calculateDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    distance = '${totalDistance.toStringAsFixed(2)} km';
    notifyListeners();
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
