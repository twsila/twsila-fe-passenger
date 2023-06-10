import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_amount_field.dart';
import '../../../../common/widgets/custom_text_input_field.dart';
import '../../../../common/widgets/multi_pick_image.dart';

class ThirdViewWidget extends StatefulWidget {
  final Function(List<XFile>?) onSelectImage;
  final Function(String?) onNotesChanged;
  final Function(String?) onAmountChanged;
  final List<XFile>? images;
  final String? notes;
  final int? amount;

  const ThirdViewWidget({
    Key? key,
    required this.onNotesChanged,
    required this.onAmountChanged,
    required this.onSelectImage,
    this.notes,
    this.amount,
    this.images,
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
    return SingleChildScrollView(
      child: Container(
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
            MutliPickImageWidget(
              images: widget.images,
              onPickedImages: widget.onSelectImage,
            ),
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
      ),
    );
  }
}
