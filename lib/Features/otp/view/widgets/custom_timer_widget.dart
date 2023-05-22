import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../common/widgets/custom_countdown_timer.dart';
import '../../bloc/otp_bloc.dart';
import '../../bloc/otp_event.dart';

class CustomTimerWidget extends StatefulWidget {
  final String mobileNumber;
  CustomTimerWidget({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget> {
  bool timeFinished = false;

  @override
  Widget build(BuildContext context) {
    return !timeFinished
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.codeArrive.tr(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: ColorManager.black, fontWeight: FontWeight.w600),
              ),
              CustomCountDownTimer(
                onTimerFinished: () {
                  setState(() {
                    timeFinished = true;
                  });
                },
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    timeFinished = false;
                  });
                  BlocProvider.of<OtpBloc>(context)
                      .add(GenerateOtpEvent(mobileNumber: widget.mobileNumber));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.replay_outlined,
                      color: ColorManager.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.codeDidntArrive.tr(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
