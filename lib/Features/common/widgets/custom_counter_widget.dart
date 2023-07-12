import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../core/utils/resources/color_manager.dart';

class CustomCounterWidget extends StatefulWidget {
  final String text;
  final double? value;
  final Function onPlusPressed;
  final Function onMinusPressed;

  const CustomCounterWidget({
    Key? key,
    this.value,
    required this.text,
    required this.onPlusPressed,
    required this.onMinusPressed,
  }) : super(key: key);
  @override
  _CustomCounterWidgetState createState() => _CustomCounterWidgetState();
}

class _CustomCounterWidgetState extends State<CustomCounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.text,
              style: getBoldStyle(
                color: ColorManager.primaryTextColor,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => widget.onPlusPressed(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Image.asset(ImageAssets.plus),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                ((widget.value ?? 0).toInt()).toString(),
                style: getMediumStyle(
                    color: ColorManager.titlesTextColor, fontSize: 18),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: widget.value == null || widget.value == 0
                    ? () {}
                    : () => widget.onMinusPressed(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: widget.value == null || widget.value == 0
                          ? ColorManager.accentColor
                          : ColorManager.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Image.asset(ImageAssets.minus),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
