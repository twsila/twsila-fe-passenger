// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:passenger/utils/secret_keys.dart';
// import 'package:url_launcher/url_launcher.dart';

// /// Determine the current position of the device.
// ///
// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.bestForNavigation,
//   );
// }

// double calculateDistanceInMeters(
//   LatLng startDestination,
//   LatLng endDestination,
// ) {
//   return Geolocator.bearingBetween(
//     startDestination.latitude,
//     startDestination.longitude,
//     endDestination.latitude,
//     endDestination.longitude,
//   );
// }

// Future<GeoData> getPredictionDetails(Prediction p) async {
//   final plist = GoogleMapsPlaces(
//     apiKey: TwsilaSecretKeys.kMapsStaticKey,
//     apiHeaders: await const GoogleApiHeaders().getHeaders(),
//   );

//   PlacesDetailsResponse detail =
//       await plist.getDetailsByPlaceId(p.placeId ?? '');
//   double lat = detail.result.geometry?.location.lat ?? 0;
//   double lng = detail.result.geometry?.location.lng ?? 0;

//   return await Geocoder2.getDataFromCoordinates(
//     latitude: lat,
//     longitude: lng,
//     googleMapApiKey: TwsilaSecretKeys.kMapsStaticKey,
//   );
// }

// Future<GeoData> getLocationName({
//   required BuildContext context,
//   required LatLng latLng,
// }) {
//   return Geocoder2.getDataFromCoordinates(
//     latitude: latLng.latitude,
//     longitude: latLng.longitude,
//     language: context.locale.languageCode,
//     googleMapApiKey: TwsilaSecretKeys.kMapsStaticKey,
//   );
// }

// String getLocationNameResult(LatLng? latLng, GeoData? positionData) {
//   if (latLng != null) {
//     if (positionData == null) {
//       return '${latLng.latitude},${latLng.longitude}';
//     } else {
//       return ('${positionData.city},${positionData.state},${positionData.country}');
//     }
//   } else {
//     return 'getting_current_location'.tr();
//   }
// }

// Future<void> openMap(
//   double startLatitude,
//   double startLongitude,
//   double endLatitude,
//   double endLongitude,
// ) async {
//   String url =
//       'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude &destination=$endLatitude,$endLongitude&travelmode=driving&dir_action=navigate';
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url));
//   } else {
//     throw 'Could not open the map.';
//   }
// }
