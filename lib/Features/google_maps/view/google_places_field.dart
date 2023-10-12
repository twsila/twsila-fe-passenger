import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/app/constants.dart';

import '../../../core/utils/location/map_provider.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/styles_manager.dart';

class GoogleMapsPlacesField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final Function(Prediction?) predictionCallback;
  GoogleMapsPlacesField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.predictionCallback,
    this.hintText,
  }) : super(key: key);

  @override
  State<GoogleMapsPlacesField> createState() => _GoogleMapsPlacesFieldState();
}

class _GoogleMapsPlacesFieldState extends State<GoogleMapsPlacesField> {
  Color fillColor = Colors.white70;
  late String googleApiKey;

  @override
  void initState() {
    if (Platform.isIOS) {
      googleApiKey = Constants.GOOGLE_API_KEY_IOS;
    } else {
      googleApiKey = Constants.GOOGLE_API_KEY_ANDROID;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Focus(
        focusNode: widget.focusNode,
        child: Consumer<MapProvider>(builder: (context, mapProvider, _) {
          return GooglePlaceAutoCompleteTextField(
            textEditingController: widget.controller,
            googleAPIKey: googleApiKey,
            debounceTime: 400,
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: ColorManager.black),
            countries: mapProvider.countries,
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              widget.predictionCallback(prediction);
            },
            itemClick: (Prediction prediction) {
              if (prediction.description != null) {
                setState(() {
                  widget.controller.text = prediction.description!;
                });
                widget.controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length));
                FocusScope.of(context).unfocus();
              }
            },
            isCrossBtnShown: false,
            boxDecoration: const BoxDecoration(),
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 8, right: 8),
              hintText: widget.hintText ?? "Search your location..",
              hintStyle:
                  getRegularStyle(color: ColorManager.grey, fontSize: 14),
              fillColor: fillColor,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: ColorManager.error,
                ),
              ),
              suffixIcon: widget.controller.text == ''
                  ? null
                  : GestureDetector(
                      child: const Icon(Icons.cancel),
                      onTap: () {
                        setState(() {
                          widget.controller.text = '';
                          widget.predictionCallback(null);
                        });
                      },
                    ),
              focusedBorder: outlineBorder(),
              disabledBorder: outlineBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: ColorManager.error,
                ),
              ),
              enabledBorder: outlineBorder(),
            ),
          );
        }),
      ),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: ColorManager.lightPrimary,
      ),
    );
  }
}
