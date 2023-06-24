import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../common/widgets/custom_back_button.dart';
import '../../../../../common/widgets/custom_close_button.dart';

class TransportationTopWidget extends StatefulWidget {
  final String text;
  final String icon;
  final PageController controller;
  final int selectedIndex;
  final int noOfScreens;

  const TransportationTopWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.selectedIndex,
    required this.noOfScreens,
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
              widget.selectedIndex == 0
                  ? const CustomCloseButton()
                  : CustomBackButton(
                      onPressed: () => widget.controller.animateToPage(
                        widget.selectedIndex - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    ),
              Image.asset(widget.icon),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.step.tr() +
                ' ${widget.selectedIndex + 1}/${widget.noOfScreens}',
            style: getMediumStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.text,
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
