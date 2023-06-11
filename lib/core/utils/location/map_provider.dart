import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/location/show_all_markers.dart';
import 'package:taxi_for_you/data/model/country.dart';

import '../../../Features/google_maps/model/location_model.dart';

class MapProvider with ChangeNotifier {
  final AppPreferences appPreferences = instance<AppPreferences>();
  GoogleMapController? controller;
  MarkerId sourceMarkerId = const MarkerId('source_location');
  MarkerId destinationMarkerId = const MarkerId('destination_location');

  //Locations
  LocationModel? currentLocation;
  List<String> countries = ['SA'];
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

  setCountry(CountryModel? country, {bool needsRebuild = true}) async {
    List<CountryModel> countriesList = appPreferences.getCountries();
    if (country == null) {
      CountryModel? countryModel = await getCountryPhoneCode();

      appPreferences.setUserSelectedCountry(countryModel);
      countries = countryModel != null ? [countryModel.country] : [];
    } else {
      CountryModel country = countriesList[0];
      appPreferences.setUserSelectedCountry(country);
      countries = [country.country];
    }

    if (!needsRebuild) return;
    notifyListeners();
  }

  Future<CountryModel?> getCountryPhoneCode() async {
    var response = await http.get(Uri.parse('http://ip-api.com/json'));
    var jsonResponse = json.decode(response.body);
    final isoCode = jsonResponse['countryCode'];

    print('country is: $isoCode');

    List<CountryModel> countriesList = appPreferences.getCountries();
    CountryModel? country = countriesList.singleWhereOrNull(
      (element) => element.country == isoCode,
    );

    return country;
  }

  //Handle Map
  animateCamera(LatLng latLng) async {
    if (controller == null) return;
    controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 16.5,
    )));
  }

  setLocation({
    LocationModel? sourceLocation,
    LocationModel? destinationLocation,
    bool removeOldPlace = false,
  }) {
    if (sourceLocation == null && destinationLocation == null) {
      removeMarker(sourceMarkerId);
      removeMarker(destinationMarkerId);
      resetPolyPoints();
      return;
    } else if (sourceLocation != null && destinationLocation == null) {
      LatLng latLng = LatLng(sourceLocation.latitude, sourceLocation.longitude);
      removeMarker(destinationMarkerId);
      resetPolyPoints();
      addMarker(Marker(markerId: sourceMarkerId, position: latLng));
      animateCamera(latLng);
      return;
    } else if (sourceLocation == null && destinationLocation != null) {
      LatLng latLng =
          LatLng(destinationLocation.latitude, destinationLocation.longitude);
      removeMarker(sourceMarkerId);
      resetPolyPoints();
      addMarker(Marker(markerId: destinationMarkerId, position: latLng));
      animateCamera(latLng);
      return;
    }
    LatLng sourcePosition =
        LatLng(sourceLocation!.latitude, sourceLocation.longitude);
    LatLng destinationPosition =
        LatLng(destinationLocation!.latitude, destinationLocation.longitude);
    if (removeOldPlace) removeMarker(sourceMarkerId);
    addMarker(
      Marker(markerId: sourceMarkerId, position: sourcePosition),
    );
    addMarker(
      Marker(markerId: destinationMarkerId, position: destinationPosition),
    );
    getPolyline(
        sourceLocation: sourceLocation,
        destinationLocation: destinationLocation);
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

  getPolyline(
      {LocationModel? sourceLocation,
      LocationModel? destinationLocation}) async {
    if (controller == null ||
        sourceLocation == null ||
        destinationLocation == null) return;
    resetPolyPoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Platform.isIOS
          ? Constants.GOOGLE_API_KEY_IOS
          : Constants.GOOGLE_API_KEY_ANDROID,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
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
