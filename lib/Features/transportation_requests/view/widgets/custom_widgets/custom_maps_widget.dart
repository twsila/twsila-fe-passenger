import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_circular_indicator.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_input_field.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_outlined_button.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/helpers/debouncer_helper.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import '../../../../../core/utils/location/user_current_location.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';

class CustomMapsWidget extends StatefulWidget {
  final String title;
  final Function(String, String, String) onSelectLocation;
  final Function onBackPressed;

  const CustomMapsWidget({
    Key? key,
    required this.title,
    required this.onSelectLocation,
    required this.onBackPressed,
  }) : super(key: key);
  @override
  _CustomMapsWidgetState createState() => _CustomMapsWidgetState();
}

class _CustomMapsWidgetState extends State<CustomMapsWidget> {
  final _debouncer = Debouncer(milliseconds: 500);
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final _appPrefs = instance<AppPreferences>();
  late final LocatitonGeocoder geocoder;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? _position;
  Marker? _marker;
  LatLng? location;
  String? address;
  bool _isAddressLoading = false;

  @override
  void initState() {
    var language = _appPrefs.getAppLanguage();
    geocoder = LocatitonGeocoder(
      Platform.isIOS
          ? Constants.GOOGLE_API_KEY_IOS
          : Constants.GOOGLE_API_KEY_ANDROID,
      lang: language,
    );
    super.initState();
  }

  void getLocation() async {
    try {
      await UserLocationService().checkLocationPermission();
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        location = LatLng(position.latitude, position.longitude);
        getAddress(location!);
        _position = CameraPosition(
          target: location!,
          zoom: 16.5,
        );
      });
    } catch (e) {
      ShowDialogHelper.showDialogPopupWithCancel(
        AppStrings.confirmation.tr(),
        AppStrings.locationEnable.tr(),
        context,
        () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        () {
          Geolocator.openLocationSettings();
          Navigator.pop(context);
          Navigator.pop(context);
        },
        dismissible: false,
      );
    }
  }

  Future getAddress(LatLng location) async {
    final coordinates = Coordinates(location.latitude, location.longitude);
    setState(() {
      _isAddressLoading = true;
    });
    try {
      var addresses = await geocoder.findAddressesFromCoordinates(coordinates);
      address = addresses.first.addressLine ??
          addresses.first.adminArea ??
          addresses.first.locality;
      setState(() {
        _marker = Marker(
            markerId: const MarkerId('sourceMarker'), position: location);
      });
    } catch (e) {
      ShowDialogHelper.showErrorMessage(e.toString(), context);
      widget.onBackPressed();
    }
    setState(() {
      _isAddressLoading = false;
    });
  }

  longLatChanged() {
    _debouncer.run(() async {
      if (_longitudeController.text != '' && _latitudeController.text != '') {
        final GoogleMapController controller = await _controller.future;
        setState(() {
          location = LatLng(double.parse(_latitudeController.text),
              double.parse(_longitudeController.text));
          getAddress(location!);
          _position = CameraPosition(
            target: location!,
            zoom: 16.5,
          );
          _marker = Marker(
              markerId: const MarkerId('sourceMarker'), position: location!);
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: location!,
            zoom: 16.5,
          )));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_position == null) getLocation();
    return _position != null
        ? Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) async {
                  _controller.complete(controller);
                },
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                onTap: (latlng) {
                  setState(() {
                    location = latlng;
                    getAddress(latlng);
                    _latitudeController.text = location!.latitude.toString();
                    _longitudeController.text = location!.longitude.toString();
                  });
                },
                initialCameraPosition: _position!,
                markers: _marker == null ? {} : {_marker!},
              ),
              Positioned(
                top: 16,
                left: 8,
                right: 8,
                child: !_isAddressLoading
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                  spreadRadius: 1,
                                  offset: Offset(0.0, 1.0),
                                )
                              ]),
                          child: Text(address ?? widget.title),
                        ),
                      )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, -7),
                      )
                    ],
                  ),
                  child: _isAddressLoading
                      ? const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: CustomCircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.selectOrEnterMap.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextInputField(
                                    controller: _longitudeController,
                                    hintText: "Longitude",
                                    borderColor: ColorManager.grey,
                                    onChanged: (value) => longLatChanged(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: CustomTextInputField(
                                    controller: _latitudeController,
                                    hintText: "Latitude",
                                    borderColor: ColorManager.grey,
                                    onChanged: (value) => longLatChanged(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomTextButton(
                              text: AppStrings.confirm.tr(),
                              onPressed: () {
                                widget.onSelectLocation(
                                  location!.latitude.toString(),
                                  location!.longitude.toString(),
                                  address!,
                                );
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: CustomTextButton(
                                text: AppStrings.cancel.tr(),
                                showIcon: false,
                                showShadow: false,
                                color: ColorManager.accentColor,
                                textColor: Colors.black,
                                onPressed: () {
                                  widget.onBackPressed();
                                },
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          )
        : const Center(child: CustomCircularProgressIndicator());
  }
}
