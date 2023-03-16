import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/goods-model.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_payment_field.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

import '../../../common/widgets/custom_checkbox.dart';
import '../../../common/widgets/custom_number_field.dart';
import '../../../common/widgets/custom_private_notes.dart';
import '../../../common/widgets/custom_text_input_field.dart';
import '../../../common/widgets/multi_pick_image.dart';

class GoodsDataField extends StatefulWidget {
  final GoodsModel goodsModel;
  const GoodsDataField({Key? key, required this.goodsModel}) : super(key: key);

  @override
  State<GoodsDataField> createState() => _GoodsDataFieldState();
}

class _GoodsDataFieldState extends State<GoodsDataField> {
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
                  CustomNumberField(
                      onChanged: (value) {
                        if (value == '' && value != null) {
                          widget.goodsModel.goodsWeight = null;
                          return;
                        }
                        widget.goodsModel.goodsWeight = int.parse(value!);
                      },
                      text: AppStrings.goodsWeight.tr()),
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
        CustomPrivateNotes(notes: widget.goodsModel.notes),
        CustomPaymentField(
          onChanged: (value) {
            if (value == '' && value != null) {
              widget.goodsModel.paymentValue = null;
              return;
            }
            widget.goodsModel.paymentValue = int.parse(value!);
          },
        )
      ],
    );
  }
}
