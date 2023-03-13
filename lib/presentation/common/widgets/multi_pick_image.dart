import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../state_renderer/dialogs.dart';

class MutliPickImageWidget extends StatefulWidget {
  final Function(List<XFile>? images) onPickedImages;
  const MutliPickImageWidget({Key? key, required this.onPickedImages})
      : super(key: key);

  @override
  State<MutliPickImageWidget> createState() => _MutliPickImageWidgetState();
}

class _MutliPickImageWidgetState extends State<MutliPickImageWidget> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        widget.onPickedImages(imagefiles);
        setState(() {});
      }
    } catch (e) {
      ShowDialogHelper.showErrorMessage(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 8, 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: openImages,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.file_upload_outlined),
                const SizedBox(width: 8),
                Text(
                  'إرفاق صور الاثاث',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
          imagefiles != null
              ? Wrap(
                  children: imagefiles!.map((imageone) {
                    return Card(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    );
                  }).toList(),
                )
              : Container()
        ],
      ),
    );
  }
}
