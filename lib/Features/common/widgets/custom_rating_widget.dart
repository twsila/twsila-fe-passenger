import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'dart:ui' as ui;

class CustomRatingWidget extends StatelessWidget {
  final AppPreferences appPreferences = instance();
  final Function(double) onSelectRating;
  final double? intialRating;
  final bool ignoreGesture;
  CustomRatingWidget(
      {Key? key,
      required this.onSelectRating,
      this.intialRating,
      this.ignoreGesture = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: intialRating != null ? intialRating!.toDouble() : 0.0,
      minRating: 1,
      direction: Axis.horizontal,
      unratedColor: ColorManager.lightGrey,
      ignoreGestures: ignoreGesture,
      textDirection: appPreferences.isEnglish()
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        onSelectRating(rating);
      },
    );
  }
}
