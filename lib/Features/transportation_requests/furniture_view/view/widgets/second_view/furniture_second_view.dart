import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_views/pageview_widgets/second_view_time/second_view_time.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_views/pageview_widgets/second_view_location/second_view_location.dart';
import '../../furniture_viewmodel.dart';

class FurnitureSecondView extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureSecondView({
    Key? key,
    required this.furnitureViewModel,
  }) : super(key: key);

  @override
  _FurnitureSecondViewState createState() => _FurnitureSecondViewState();
}

class _FurnitureSecondViewState extends State<FurnitureSecondView> {
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
                  date: widget.furnitureViewModel.furnitureModel.date,
                  onSelectDate: (date, stringDate) {
                    Future.delayed(Duration.zero, () {
                      if (mounted) {
                        setState(() {
                          widget.furnitureViewModel.furnitureModel.stringDate =
                              stringDate;
                          widget.furnitureViewModel.furnitureModel.date = date;
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
                      widget.furnitureViewModel.furnitureModel
                          .pickupLocationName = locationName;
                      widget.furnitureViewModel.furnitureModel
                          .pickupLocationLatitude = lat;
                      widget.furnitureViewModel.furnitureModel
                          .pickupLocationLongitude = long;
                      widget.furnitureViewModel.secondScreenValid.value =
                          widget.furnitureViewModel.validateSecondScreen();
                    });
                  },
                  onSelectDestinPlace: (lat, long, locationName) {
                    setState(() {
                      widget.furnitureViewModel.furnitureModel
                          .destinationLocationName = locationName;
                      widget.furnitureViewModel.furnitureModel
                          .destinationLocationLatitude = lat;
                      widget.furnitureViewModel.furnitureModel
                          .destinationLocationLongitude = long;
                      widget.furnitureViewModel.secondScreenValid.value =
                          widget.furnitureViewModel.validateSecondScreen();
                    });
                  },
                  pickupLocationName: widget
                      .furnitureViewModel.furnitureModel.pickupLocationName,
                  destinLocationString: widget.furnitureViewModel.furnitureModel
                      .destinationLocationName,
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
                valueListenable: widget.furnitureViewModel.secondScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.furnitureViewModel.handleSteps();
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
