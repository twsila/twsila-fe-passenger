import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_views/transport_request_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_views/widgets/pageview_widgets/second_view_time/second_view_time.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';
import '../widgets/pageview_widgets/second_view_location/second_view_location.dart';

class TransportSecondView extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  final TransportRequestViewModel viewModel;

  const TransportSecondView({
    Key? key,
    required this.transportationBaseModel,
    required this.viewModel,
  }) : super(key: key);

  @override
  _TransportSecondViewState createState() => _TransportSecondViewState();
}

class _TransportSecondViewState extends State<TransportSecondView> {
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
                  date: widget.transportationBaseModel.date,
                  onSelectDate: (date, stringDate) {
                    Future.delayed(Duration.zero, () {
                      if (mounted) {
                        setState(() {
                          widget.transportationBaseModel.stringDate =
                              stringDate;
                          widget.transportationBaseModel.date = date;
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
                      widget.transportationBaseModel.pickupLocationName =
                          locationName;
                      widget.transportationBaseModel.pickupLocationLatitude =
                          lat;
                      widget.transportationBaseModel.pickupLocationLongitude =
                          long;
                      widget.viewModel.secondScreenValid.value =
                          widget.viewModel.validateSecondScreen();
                    });
                  },
                  onSelectDestinPlace: (lat, long, locationName) {
                    setState(() {
                      widget.transportationBaseModel.destinationLocationName =
                          locationName;
                      widget.transportationBaseModel
                          .destinationLocationLatitude = lat;
                      widget.transportationBaseModel
                          .destinationLocationLongitude = long;
                      widget.viewModel.secondScreenValid.value =
                          widget.viewModel.validateSecondScreen();
                    });
                  },
                  pickupLocationName:
                      widget.transportationBaseModel.pickupLocationName,
                  destinLocationString:
                      widget.transportationBaseModel.destinationLocationName,
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
                valueListenable: widget.viewModel.secondScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.viewModel.handleSteps();
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
