import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/resources/strings_manager.dart';

class CustomInfoStringWidget extends StatelessWidget {
  final String info;
  final String? text;
  const CustomInfoStringWidget({
    Key? key,
    required this.info,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              info,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text ?? AppStrings.nothing.tr(),
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

class CustomInfoIntWidget extends StatelessWidget {
  final String info;
  final int? text;
  const CustomInfoIntWidget({
    Key? key,
    required this.info,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            info,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14),
          ),
          const SizedBox(width: 8),
          Text(
            text != null ? text.toString() : AppStrings.nothing.tr(),
            textAlign: TextAlign.start,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class CustomInfoBooleanWidget extends StatelessWidget {
  final bool booleanValue;
  final String info;
  const CustomInfoBooleanWidget(
      {Key? key, required this.booleanValue, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            info,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14),
          ),
          const SizedBox(width: 8),
          Text(
            booleanValue ? AppStrings.ok.tr() : AppStrings.no.tr(),
            textAlign: TextAlign.start,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
