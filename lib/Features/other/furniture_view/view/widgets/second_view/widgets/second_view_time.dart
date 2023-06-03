import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_date_picker.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../../../../../app/app_prefs.dart';
import '../../../../../../../app/di.dart';
import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/styles_manager.dart';

class SecondViewTime extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const SecondViewTime({Key? key, required this.furnitureViewModel})
      : super(key: key);
  @override
  _SecondViewTimeState createState() => _SecondViewTimeState();
}

class _SecondViewTimeState extends State<SecondViewTime> {
  bool isNow = true;
  String dateFormatterString = 'dd MMM yyyy/ hh:mm a';
  final _appPrefs = instance<AppPreferences>();
  final dateNow = DateTime.now();
  final timeNow = TimeOfDay.now();
  late DateTime dateTime;

  @override
  void initState() {
    dateTime = DateTime(
      dateNow.year,
      dateNow.month,
      dateNow.day,
      timeNow.hour,
      timeNow.minute,
    );
    widget.furnitureViewModel.secondScreenValid.value = true;
    super.initState();
  }

  convertDate() {
    String dateFormatted =
        DateFormat(dateFormatterString, _appPrefs.getAppLanguage())
            .format(dateTime);
    widget.furnitureViewModel.furnitureModel.date = dateFormatted;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.whenService.tr(),
          style: getMediumStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  isNow = true;
                  convertDate();
                  widget.furnitureViewModel.secondScreenValid.value = true;
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        isNow ? ColorManager.secondaryLightColor : Colors.white,
                    border: isNow
                        ? null
                        : Border.all(color: ColorManager.secondaryLightColor),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(ImageAssets.thunder),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          AppStrings.fastestTime.tr(),
                          style: getBoldStyle(
                              color: ColorManager.primaryTextColor,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  isNow = false;
                  widget.furnitureViewModel.furnitureModel.date = null;
                  widget.furnitureViewModel.secondScreenValid.value = false;
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        isNow ? Colors.white : ColorManager.secondaryLightColor,
                    border: isNow
                        ? Border.all(color: ColorManager.secondaryLightColor)
                        : null,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(ImageAssets.clock),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          AppStrings.specifiedTime.tr(),
                          style: getBoldStyle(
                              color: ColorManager.primaryTextColor,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!isNow)
          Column(
            children: [
              const SizedBox(height: 16),
              CustomDatePickerWidget(
                onSelectDate: (date, dateTime) {
                  widget.furnitureViewModel.furnitureModel.date = date;
                  Future.delayed(
                      Duration.zero,
                      () => widget.furnitureViewModel.secondScreenValid.value =
                          true);
                },
                firstDate: DateTime.now(),
              )
            ],
          )
      ],
    );
  }
}
