import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import '../../../core/utils/resources/strings_manager.dart';

class EasyLoader extends StatefulWidget {
  const EasyLoader({
    Key? key,
  }) : super(key: key);

  @override
  _EasyLoaderState createState() => _EasyLoaderState();
}

class _EasyLoaderState extends State<EasyLoader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withAlpha(100),
        ),
        Center(
            child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              const SpinKitCircle(color: Colors.white),
              const SizedBox(width: 24),
              Text(
                AppStrings.loading.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
              DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText('...',
                        speed: const Duration(
                          milliseconds: 500,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
