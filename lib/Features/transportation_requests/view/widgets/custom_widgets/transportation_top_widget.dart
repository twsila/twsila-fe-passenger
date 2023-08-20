import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/transport_request_viewmodel.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';

import '../../../../../app/constants.dart';
import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_back_button.dart';
import '../../../../common/widgets/custom_close_button.dart';

class TransportationTopWidget extends StatefulWidget {
  final TransportRequestViewModel transportViewModel;

  const TransportationTopWidget({
    Key? key,
    required this.transportViewModel,
  }) : super(key: key);
  @override
  _TransportationTopWidgetState createState() =>
      _TransportationTopWidgetState();
}

class _TransportationTopWidgetState extends State<TransportationTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.transportViewModel.selectedIndex.value == 0
                  ? CustomCloseButton(
                      onPressed: () => widget.transportViewModel.cacheOnBack(),
                    )
                  : CustomBackButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        widget.transportViewModel.controller.animateToPage(
                          widget.transportViewModel.selectedIndex.value - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
              Image.asset(TripHelper.getIconName(
                  widget.transportViewModel.transportationBaseModel.tripType!)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.step.tr() +
                ' ${widget.transportViewModel.selectedIndex.value + 1}/${widget.transportViewModel.screens.length}',
            style: getMediumStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 16,
            ),
          ),
          Text(
            TripHelper.getTripTitle(
                widget.transportViewModel.transportationBaseModel.tripType!),
            style: getBoldStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
