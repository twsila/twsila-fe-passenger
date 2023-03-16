import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/resources/strings_manager.dart';
import 'custom_text_input_field.dart';

class CustomPrivateNotes extends StatelessWidget {
  String? notes;
  CustomPrivateNotes({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.privateNotes.tr(),
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomTextInputField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              padding: const EdgeInsets.all(8),
              onChanged: (text) {
                notes = text;
              },
            ),
          ),
        ],
      ),
    );
  }
}
