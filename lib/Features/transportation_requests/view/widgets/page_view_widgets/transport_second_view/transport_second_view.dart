import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_second_view/widgets/second_view_location/second_view_location.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_second_view/widgets/second_view_time/second_view_time.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../model/transportation_base_model.dart';
import '../../../transport_request_viewmodel.dart';

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
  void initState() {
    widget.viewModel.secondScreenValid.value =
        widget.viewModel.validateSecondScreen();
    super.initState();
  }

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
                      widget.transportationBaseModel.pickupLocation
                          .locationName = locationName;
                      widget.transportationBaseModel.pickupLocation.latitude =
                          double.tryParse(lat);
                      widget.transportationBaseModel.pickupLocation.longitude =
                          double.tryParse(long);
                      widget.viewModel.secondScreenValid.value =
                          widget.viewModel.validateSecondScreen();
                    });
                  },
                  onSelectDestinPlace: (lat, long, locationName) {
                    setState(() {
                      widget.transportationBaseModel.destinationLocation
                          .locationName = locationName;
                      widget.transportationBaseModel.destinationLocation
                          .latitude = double.tryParse(lat);
                      widget.transportationBaseModel.destinationLocation
                          .longitude = double.tryParse(long);
                      widget.viewModel.secondScreenValid.value =
                          widget.viewModel.validateSecondScreen();
                    });
                  },
                  pickupLocationName: widget
                      .transportationBaseModel.pickupLocation.locationName,
                  destinLocationString: widget
                      .transportationBaseModel.destinationLocation.locationName,
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
