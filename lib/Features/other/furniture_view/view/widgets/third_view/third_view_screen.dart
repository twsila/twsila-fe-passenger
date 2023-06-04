import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_amount_field.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../../common/widgets/custom_text_input_field.dart';
import '../../furniture_viewmodel.dart';

class FurnitureThirdView extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureThirdView({
    Key? key,
    required this.furnitureViewModel,
  }) : super(key: key);

  @override
  _FurnitureThirdViewState createState() => _FurnitureThirdViewState();
}

class _FurnitureThirdViewState extends State<FurnitureThirdView> {
  final TextEditingController notesController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    notesController.text = widget.furnitureViewModel.furnitureModel.notes ?? '';
    super.initState();
  }

  @override
  void dispose() {
    notesController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(32),
          child: Column(
            children: [
              CustomTextInputField(
                controller: notesController,
                keyboardType: TextInputType.multiline,
                multiLines: true,
                hintText: AppStrings.notesHint.tr(),
                onChanged: (text) {
                  if (text != '') {
                    widget.furnitureViewModel.furnitureModel.notes = text;
                  } else {
                    widget.furnitureViewModel.furnitureModel.notes = null;
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomAmountField(
                onChanged: (text) {
                  if (text != null && text != '') {
                    widget.furnitureViewModel.furnitureModel.paymentValue =
                        int.parse(text);
                    widget.furnitureViewModel.thirdScreenValid.value = true;
                  } else {
                    widget.furnitureViewModel.furnitureModel.paymentValue =
                        null;
                    widget.furnitureViewModel.thirdScreenValid.value = false;
                  }
                },
                controller: amountController,
              ),
              const SizedBox(height: 64),
            ],
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
                valueListenable: widget.furnitureViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.furnitureViewModel.furnitureModel);
                            }
                          : null);
                }),
          ),
        ),
      ],
    );
  }
}
