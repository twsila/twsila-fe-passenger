import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/strings_manager.dart';

class CustomPrivateNotesShow extends StatelessWidget {
  final String? notes;
  const CustomPrivateNotesShow({Key? key, required this.notes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(
            AppStrings.privateNotes.tr(),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              notes ?? AppStrings.nothing.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
