import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../core/utils/resources/strings_manager.dart';

class CustomPaymentFieldShow extends StatelessWidget {
  final _appPrefs = instance<AppPreferences>();
  int? paymentValue;
  CustomPaymentFieldShow({Key? key, required this.paymentValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return paymentValue != null
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.paymentValue.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        paymentValue.toString(),
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _appPrefs.getUserSelectedCountry() == "SA"
                            ? AppStrings.saudiCurrency.tr()
                            : AppStrings.egpCurrency.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
