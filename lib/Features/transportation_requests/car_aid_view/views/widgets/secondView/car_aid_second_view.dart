import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/car_aid_view/views/car_aid_viewmodel.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_views/pageview_widgets/second_view_location/second_view_location.dart';
import '../../../../common/common_views/pageview_widgets/second_view_time/second_view_time.dart';

class CarAidSecondView extends StatefulWidget {
  final CarAidViewModel carAidViewModel;

  const CarAidSecondView({
    Key? key,
    required this.carAidViewModel,
  }) : super(key: key);
  @override
  _CarAidSecondViewState createState() => _CarAidSecondViewState();
}

class _CarAidSecondViewState extends State<CarAidSecondView> {
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
                  date: widget.carAidViewModel.carAidModel.date,
                  onSelectDate: (date) {
                    Future.delayed(Duration.zero, () {
                      if (mounted) {
                        setState(() {
                          widget.carAidViewModel.carAidModel.date = date;
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
                      widget.carAidViewModel.carAidModel.sourceLocationString =
                          locationName;
                      widget.carAidViewModel.carAidModel
                          .pickupLocationLatitude = lat;
                      widget.carAidViewModel.carAidModel
                          .pickupLocationLongitude = long;
                      widget.carAidViewModel.secondScreenValid.value =
                          widget.carAidViewModel.validateSecondScreen();
                    });
                  },
                  onSelectDestinPlace: (lat, long, locationName) {
                    setState(() {
                      widget.carAidViewModel.carAidModel
                          .destinationLocationString = locationName;
                      widget.carAidViewModel.carAidModel
                          .destinationLocationLatitude = lat;
                      widget.carAidViewModel.carAidModel
                          .destinationLocationLongitude = long;
                      widget.carAidViewModel.secondScreenValid.value =
                          widget.carAidViewModel.validateSecondScreen();
                    });
                  },
                  sourceLocationString:
                      widget.carAidViewModel.carAidModel.sourceLocationString,
                  destinLocationString: widget
                      .carAidViewModel.carAidModel.destinationLocationString,
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
                valueListenable: widget.carAidViewModel.secondScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.carAidViewModel.handleSteps();
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
