import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/goods-model.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

import '../../../common/widgets/custom_checkbox.dart';
import '../../../common/widgets/custom_text_input_field.dart';
import '../../../common/widgets/multi_pick_image.dart';

class GoodsDataField extends StatefulWidget {
  final GoodsModel goodsModel;
  const GoodsDataField({Key? key, required this.goodsModel}) : super(key: key);

  @override
  State<GoodsDataField> createState() => _GoodsDataFieldState();
}

class _GoodsDataFieldState extends State<GoodsDataField> {
  Widget numberField(String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 45,
          child: widget,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      checked: widget.goodsModel.craneBool,
                      fieldName: AppStrings.crane.tr(),
                      onChange: (checked) {
                        widget.goodsModel.craneBool = checked;
                      }),
                  numberField(
                      AppStrings.goodsWeight.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.goodsModel.goodsWeight = null;
                            return;
                          }
                          widget.goodsModel.goodsWeight = int.parse(value);
                        },
                      )),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      checked: widget.goodsModel.loadingBool,
                      fieldName: AppStrings.unloadAndLoad.tr(),
                      onChange: (checked) {
                        widget.goodsModel.loadingBool = checked;
                      }),
                  CustomCheckBox(
                      checked: widget.goodsModel.wrappingBool,
                      fieldName: AppStrings.wrapping.tr(),
                      onChange: (checked) {
                        widget.goodsModel.wrappingBool = checked;
                      }),
                ],
              ),
            )
          ],
        ),
        MutliPickImageWidget(
          onPickedImages: (images) => widget.goodsModel.images = images,
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextInputField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  padding: const EdgeInsets.all(8),
                  onChanged: (text) {
                    widget.goodsModel.notes = text;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.privateNotes.tr(),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }
}
