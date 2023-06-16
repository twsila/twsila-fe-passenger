import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/freezers_view/view/freezers_viewmodel.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_views/pageview_widgets/second_view_location/second_view_location.dart';
import '../../../../common/common_views/pageview_widgets/second_view_time/second_view_time.dart';

class FreezerSecondView extends StatefulWidget {
  final FreezersViewModel freezersViewModel;
  const FreezerSecondView({
    Key? key,
    required this.freezersViewModel,
  }) : super(key: key);

  @override
  State<FreezerSecondView> createState() => _FreezerSecondViewState();
}

class _FreezerSecondViewState extends State<FreezerSecondView> {
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
                  date: widget.freezersViewModel.freezersModel.date,
                  onSelectDate: (date) {
                    Future.delayed(Duration.zero, () {
                      if (mounted) {
                        setState(() {
                          widget.freezersViewModel.freezersModel.date = date;
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
                      widget.freezersViewModel.freezersModel
                          .sourceLocationString = locationName;
                      widget.freezersViewModel.freezersModel
                          .pickupLocationLatitude = lat;
                      widget.freezersViewModel.freezersModel
                          .pickupLocationLongitude = long;
                      widget.freezersViewModel.secondScreenValid.value =
                          widget.freezersViewModel.validateSecondScreen();
                    });
                  },
                  onSelectDestinPlace: (lat, long, locationName) {
                    setState(() {
                      widget.freezersViewModel.freezersModel
                          .destinationLocationString = locationName;
                      widget.freezersViewModel.freezersModel
                          .destinationLocationLatitude = lat;
                      widget.freezersViewModel.freezersModel
                          .destinationLocationLongitude = long;
                      widget.freezersViewModel.secondScreenValid.value =
                          widget.freezersViewModel.validateSecondScreen();
                    });
                  },
                  sourceLocationString: widget
                      .freezersViewModel.freezersModel.sourceLocationString,
                  destinLocationString: widget.freezersViewModel.freezersModel
                      .destinationLocationString,
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
                valueListenable: widget.freezersViewModel.secondScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.freezersViewModel.handleSteps();
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
