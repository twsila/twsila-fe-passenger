import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_details_widget/trips_details_widget_viewmodel.dart';
import 'package:taxi_for_you/data/model/trip_type.dart';

import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_dashed_line.dart';

class TripDetailsWidget extends StatefulWidget {
  final TripType tripType;
  const TripDetailsWidget({
    Key? key,
    required this.tripType,
  }) : super(key: key);

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  final TripsDetailsWidgetViewModel _viewModel = TripsDetailsWidgetViewModel();

  @override
  void initState() {
    _viewModel.setTripType(widget.tripType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(' تم ارسالة الاحد ١٣ ابريل, ٢٠٢٣'),
            Image.asset(_viewModel.getIconName()),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _viewModel.getTitle(),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'بميزانية ٩٠٠ ريال سعودي',
          style: getMediumStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Image.asset(ImageAssets.pin),
            const SizedBox(width: 16),
            Text(
              'من سوق البوادي',
              style: getMediumStyle(
                color: ColorManager.primaryTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(5),
          height: 33,
          width: 3,
          child: CustomPaint(
              size: const Size(1, double.infinity),
              painter: DashedLineVerticalPainter()),
        ),
        Row(
          children: [
            Image.asset(ImageAssets.pin),
            const SizedBox(width: 16),
            Text(
              'الي طريق الجامعة',
              style: getMediumStyle(
                color: ColorManager.primaryTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
