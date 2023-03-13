import 'package:flutter/material.dart';

import '../../../../domain/model/models.dart';
import '../../../common/widgets/custom_checkbox.dart';
import '../../../common/widgets/custom_text_input_field.dart';
import '../../../common/widgets/multi_pick_image.dart';

class DataFieldsWidget extends StatefulWidget {
  final FurnitureModel furnitureModel;
  const DataFieldsWidget({Key? key, required this.furnitureModel})
      : super(key: key);

  @override
  State<DataFieldsWidget> createState() => _DataFieldsWidgetState();
}

class _DataFieldsWidgetState extends State<DataFieldsWidget> {
  Widget numberField(String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 45,
          child: widget,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.headline3,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCheckBox(
                    checked: widget.furnitureModel.assembleBool,
                    fieldName: 'فك و تركيب',
                    onChange: (checked) {
                      widget.furnitureModel.assembleBool = checked;
                    }),
                CustomCheckBox(
                    checked: widget.furnitureModel.craneBool,
                    fieldName: 'رافعة',
                    onChange: (checked) {
                      widget.furnitureModel.craneBool = checked;
                    }),
                numberField(
                    'عدد الثلاجات',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.fridgeNumber = null;
                          return;
                        }
                        widget.furnitureModel.fridgeNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'عدد السجاد',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.carpetsNumber = null;
                          return;
                        }
                        widget.furnitureModel.carpetsNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'عدد مطبخ',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.kitchenNumber = null;
                          return;
                        }
                        widget.furnitureModel.kitchenNumber = int.parse(value);
                      },
                    )),
                const SizedBox(height: 70)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCheckBox(
                    checked: widget.furnitureModel.loadingBool,
                    fieldName: 'تفريغ و تحميل',
                    onChange: (checked) {
                      widget.furnitureModel.loadingBool = checked;
                    }),
                CustomCheckBox(
                    checked: widget.furnitureModel.wrappingBool,
                    fieldName: 'تغليف',
                    onChange: (checked) {
                      widget.furnitureModel.wrappingBool = checked;
                    }),
                numberField(
                    'عدد غرف النوم',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.roomsNumber = null;
                          return;
                        }
                        widget.furnitureModel.roomsNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'طقم الكنب',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.carpetsNumber = null;
                          return;
                        }
                        widget.furnitureModel.carpetsNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'عدد المكيفات',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.airconditionerNumber = null;
                          return;
                        }
                        widget.furnitureModel.airconditionerNumber =
                            int.parse(value);
                      },
                    )),
                numberField(
                    'غرفة سفرة',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          widget.furnitureModel.diningRoomNumber = null;
                          return;
                        }
                        widget.furnitureModel.diningRoomNumber =
                            int.parse(value);
                      },
                    )),
              ],
            )
          ],
        ),
        MutliPickImageWidget(
          onPickedImages: (images) => widget.furnitureModel.images = images,
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
                    widget.furnitureModel.notes = text;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ملاحظات خاصة',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }
}
