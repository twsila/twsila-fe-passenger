import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_amount_field.dart';
import '../../../../common/widgets/custom_text_input_field.dart';

class ThirdViewWidget extends StatefulWidget {
  final String? notes;
  final int? amount;
  final Function(String?) onNotesChanged;
  final Function(String?) onAmountChanged;

  const ThirdViewWidget({
    Key? key,
    required this.onNotesChanged,
    required this.onAmountChanged,
    this.notes,
    this.amount,
  }) : super(key: key);
  @override
  State<ThirdViewWidget> createState() => _ThirdViewWidgetState();
}

class _ThirdViewWidgetState extends State<ThirdViewWidget> {
  final TextEditingController notesController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    notesController.text = widget.notes ?? '';
    amountController.text =
        (widget.amount != null) ? widget.amount.toString() : '';
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
    return Container(
      margin: const EdgeInsets.all(32),
      child: Column(
        children: [
          CustomTextInputField(
            controller: notesController,
            keyboardType: TextInputType.multiline,
            multiLines: true,
            hintText: AppStrings.notesHint.tr(),
            onChanged: (text) {
              widget.onNotesChanged(text);
            },
          ),
          const SizedBox(height: 16),
          // MutliPickImageWidget(
          //   onPickedImages: (images) =>
          //       widget.furnitureViewModel.furnitureModel.images = images,
          // ),
          const SizedBox(height: 16),
          CustomAmountField(
            onChanged: (text) {
              widget.onAmountChanged(text);
            },
            controller: amountController,
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
