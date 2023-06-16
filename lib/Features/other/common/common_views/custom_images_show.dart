import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/resources/strings_manager.dart';

class CustomShowImagesWidget extends StatelessWidget {
  final List<XFile>? images;
  const CustomShowImagesWidget({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.pickedImages.tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 18),
              ),
              Wrap(
                children: images!.map((imageone) {
                  return Card(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.file(File(imageone.path)),
                    ),
                  );
                }).toList(),
              ),
            ],
          )
        : Container();
  }
}
