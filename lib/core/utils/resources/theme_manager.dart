import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    // ripple effect color
    // cardview theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: 4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: 4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle:
            getRegularStyle(fontSize: 16, color: ColorManager.white)),
    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.white, fontSize: 17),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)))),

    textTheme: TextTheme(
        displayLarge: getBoldStyle(color: ColorManager.black, fontSize: 22),
        displayMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: 14),
        displaySmall: getMediumStyle(color: ColorManager.grey, fontSize: 14),
        headlineLarge:
            getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: 18),
        headlineMedium:
            getRegularStyle(color: ColorManager.darkGrey, fontSize: 14),
        titleLarge: getBoldStyle(color: ColorManager.primary, fontSize: 30),
        titleMedium: getMediumStyle(color: ColorManager.primary, fontSize: 24),
        titleSmall: getRegularStyle(color: ColorManager.white, fontSize: 16),
        bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey, fontSize: 18),
        bodyMedium: getMediumStyle(color: ColorManager.black, fontSize: 14),
        labelSmall: getBoldStyle(color: ColorManager.primary, fontSize: 12)),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.grey, fontSize: 14),
        labelStyle: getMediumStyle(color: ColorManager.grey, fontSize: 14),
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.error, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8)))),
    // label style
  );
}
