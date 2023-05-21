import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';

import '../../../core/utils/helpers/number_helper.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/langauge_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';

class CustomCountDownTimer extends StatefulWidget {
  final int otpCountTime;
  final Function onTimerFinished;

  const CustomCountDownTimer(
      {Key? key,
      required this.onTimerFinished,
      this.otpCountTime = Constants.otpCountTime})
      : super(key: key);

  @override
  _CustomCountDownTimerState createState() => _CustomCountDownTimerState();
}

class _CustomCountDownTimerState extends State<CustomCountDownTimer> {
  final interval = const Duration(seconds: 1);

  AppPreferences appPreferences = instance();

  int currentSeconds = 0;

  String get timerText => appPreferences.getAppLanguage() ==
          LanguageType.ARABIC.getValue()
      ? '${((widget.otpCountTime - currentSeconds) % 60).toString().padLeft(2, '0')} : ${((widget.otpCountTime - currentSeconds) ~/ 60).toString().padLeft(2, '0')}'
      : '${((widget.otpCountTime - currentSeconds) ~/ 60).toString().padLeft(2, '0')} : ${((widget.otpCountTime - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= widget.otpCountTime) {
          timer.cancel();
          widget.onTimerFinished();
        }
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          LanguageNumbersHelper().replaceArabicNumber(timerText),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: ColorManager.blackTextColor,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          AppStrings.seconds.tr(),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: ColorManager.blackTextColor,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
        ),
      ],
    );
  }
}
