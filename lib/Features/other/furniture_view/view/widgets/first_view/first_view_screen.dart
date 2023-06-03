import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/first_view/widgets/first_view_booleans.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/first_view/widgets/first_view_numbers.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../furniture_viewmodel.dart';

class FurnitureFirstView extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureFirstView({
    Key? key,
    required this.furnitureViewModel,
  }) : super(key: key);
  @override
  _FurnitureFirstViewState createState() => _FurnitureFirstViewState();
}

class _FurnitureFirstViewState extends State<FurnitureFirstView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FirstViewNumbersWidget(
                  furnitureViewModel: widget.furnitureViewModel,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: const Divider(),
                ),
                FirstViewBooleans(
                  furnitureViewModel: widget.furnitureViewModel,
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
              color: Colors.white.withOpacity(0.8),
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
                valueListenable: widget.furnitureViewModel.firstScreenValid,
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
