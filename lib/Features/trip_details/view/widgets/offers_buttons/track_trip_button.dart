import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';

class TrackTripButton extends StatelessWidget {
  final int tripId;
  const TrackTripButton({Key? key, required this.tripId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: CustomTextButton(
        text: AppStrings.tripTrack.tr(),
        showShadow: false,
        hasBorder: true,
        imageData: ImageAssets.tripTrack,
        onPressed: () {},
      ),
    );
  }
}
