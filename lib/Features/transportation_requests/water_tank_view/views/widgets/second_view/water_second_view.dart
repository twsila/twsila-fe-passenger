import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/water_tank_view/views/water_viewmodel.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_views/pageview_widgets/second_view_location/second_view_location.dart';
import '../../../../common/common_views/pageview_widgets/second_view_time/second_view_time.dart';

class WaterSecondView extends StatefulWidget {
  final WaterTankViewModel waterTankViewModel;
  const WaterSecondView({
    Key? key,
    required this.waterTankViewModel,
  }) : super(key: key);

  @override
  State<WaterSecondView> createState() => _WaterSecondViewState();
}

class _WaterSecondViewState extends State<WaterSecondView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondViewTime(
                  date: widget.waterTankViewModel.waterModel.date,
                  onSelectDate: (date, stringDate) {
                    Future.delayed(Duration.zero, () {
                      if (mounted) {
                        setState(() {
                          widget.waterTankViewModel.waterModel.stringDate =
                              stringDate;
                          widget.waterTankViewModel.waterModel.date = date;
                        });
                      }
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: const Divider(),
                ),
                SecondViewLocation(
                  onSelectSourcePlace: (lat, long, locationName) {
                    setState(() {
                      widget.waterTankViewModel.waterModel.pickupLocationName =
                          locationName;
                      widget.waterTankViewModel.waterModel
                          .pickupLocationLatitude = lat;
                      widget.waterTankViewModel.waterModel
                          .pickupLocationLongitude = long;
                      widget.waterTankViewModel.secondScreenValid.value =
                          widget.waterTankViewModel.validateSecondScreen();
                    });
                  },
                  onSelectDestinPlace: (lat, long, locationName) {
                    setState(() {
                      widget.waterTankViewModel.waterModel
                          .destinationLocationName = locationName;
                      widget.waterTankViewModel.waterModel
                          .destinationLocationLatitude = lat;
                      widget.waterTankViewModel.waterModel
                          .destinationLocationLongitude = long;
                      widget.waterTankViewModel.secondScreenValid.value =
                          widget.waterTankViewModel.validateSecondScreen();
                    });
                  },
                  pickupLocationName:
                      widget.waterTankViewModel.waterModel.pickupLocationName,
                  destinLocationString: widget
                      .waterTankViewModel.waterModel.destinationLocationName,
                ),
                const SizedBox(
                  height: 64,
                )
              ],
            ),
          ),
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
            child: ValueListenableBuilder(
                valueListenable: widget.waterTankViewModel.secondScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.waterTankViewModel.handleSteps();
                              });
                            }
                          : null);
                }),
          ),
        ),
      ],
    );
  }
}
