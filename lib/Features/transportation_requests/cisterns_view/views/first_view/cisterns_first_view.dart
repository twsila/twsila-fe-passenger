import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/cisterns_view/views/cisterns_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/cisterns_view/views/first_view/widgets/cisterns_dropdowns_view.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';

class CisternsFirstView extends StatefulWidget {
  final CisternsViewModel cisternsViewModel;
  const CisternsFirstView({
    Key? key,
    required this.cisternsViewModel,
  }) : super(key: key);

  @override
  State<CisternsFirstView> createState() => _CisternsFirstViewState();
}

class _CisternsFirstViewState extends State<CisternsFirstView> {
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
                CisternsDropdownsView(
                  cisternsViewModel: widget.cisternsViewModel,
                ),
                const SizedBox(height: 64),
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
                valueListenable: widget.cisternsViewModel.firstScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.cisternsViewModel.handleSteps();
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
