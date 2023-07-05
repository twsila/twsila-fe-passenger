import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

import '../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../core/utils/resources/langauge_manager.dart';
import '../../../../../../common/widgets/custom_amount_field.dart';
import '../../../../../../common/widgets/custom_text_input_field.dart';
import '../../../../../../common/widgets/multi_pick_image.dart';

class ThirdViewWidget extends StatefulWidget {
  final Function(List<XFile>?)? onSelectImage;
  final Function(String?) onNotesChanged;
  final Function(String?) onAmountChanged;
  final List<XFile>? images;
  final String? notes;
  final int? amount;
  final bool hasImages;

  const ThirdViewWidget({
    Key? key,
    required this.onNotesChanged,
    required this.onAmountChanged,
    this.onSelectImage,
    this.notes,
    this.amount,
    this.images,
    this.hasImages = true,
  }) : super(key: key);
  @override
  State<ThirdViewWidget> createState() => _ThirdViewWidgetState();
}

class _ThirdViewWidgetState extends State<ThirdViewWidget> {
  final AppPreferences _appPrefs = instance();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.privateNotes.tr(),
                ),
                const SizedBox(width: 4),
                Tooltip(
                  showDuration: const Duration(seconds: 3),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  message: _appPrefs.getAppLanguage() ==
                          LanguageType.ENGLISH.getValue()
                      ? """
Example:
Number of boxes: 50
Box size: 10kg"""
                      : """
مثال:
عدد الصناديق: ٥٠
وزن الصندوق: ١٠""",
                  triggerMode: TooltipTriggerMode.tap,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(_appPrefs.getAppLanguage() ==
                            LanguageType.ENGLISH.getValue()
                        ? 2 * math.pi
                        : math.pi),
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(ImageAssets.question)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
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
            if (widget.onSelectImage != null && widget.hasImages)
              MutliPickImageWidget(
                images: widget.images,
                onPickedImages: widget.onSelectImage!,
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
