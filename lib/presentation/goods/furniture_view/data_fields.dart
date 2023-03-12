import 'package:flutter/material.dart';

import '../../common/widgets/custom_checkbox.dart';
import '../../common/widgets/custom_text_input_field.dart';
import '../../common/widgets/multi_pick_image.dart';
import '../../google_maps/helpers/set_result.dart';

class DataFieldsWidget extends StatefulWidget {
  const DataFieldsWidget({Key? key}) : super(key: key);

  @override
  State<DataFieldsWidget> createState() => _DataFieldsWidgetState();
}

class _DataFieldsWidgetState extends State<DataFieldsWidget> {
  final results = Results();

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
                    checked: results.assembleBool,
                    fieldName: 'فك و تركيب',
                    onChange: (checked) {
                      results.assembleBool = checked;
                    }),
                CustomCheckBox(
                    checked: results.craneBool,
                    fieldName: 'رافعة',
                    onChange: (checked) {
                      results.craneBool = checked;
                    }),
                numberField(
                    'عدد الثلاجات',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.fridgeNumber = null;
                          return;
                        }
                        results.fridgeNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'عدد السجاد',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.carpetsNumber = null;
                          return;
                        }
                        results.carpetsNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'عدد مطبخ',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.kitchenNumber = null;
                          return;
                        }
                        results.kitchenNumber = int.parse(value);
                      },
                    )),
                const SizedBox(height: 70)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCheckBox(
                    checked: results.loadingBool,
                    fieldName: 'تفريغ و تحميل',
                    onChange: (checked) {
                      results.loadingBool = checked;
                    }),
                CustomCheckBox(
                    checked: results.wrappingBool,
                    fieldName: 'تغليف',
                    onChange: (checked) {
                      results.wrappingBool = checked;
                    }),
                numberField(
                    'عدد غرف النوم',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.roomsNumber = null;
                          return;
                        }
                        results.roomsNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'طقم الكنب',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.carpetsNumber = null;
                          return;
                        }
                        results.carpetsNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'عدد المكيفات',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.airconditionerNumber = null;
                          return;
                        }
                        results.airconditionerNumber = int.parse(value);
                      },
                    )),
                numberField(
                    'غرفة سفرة',
                    CustomTextInputField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          results.diningRoomNumber = null;
                          return;
                        }
                        results.diningRoomNumber = int.parse(value);
                      },
                    )),
              ],
            )
          ],
        ),
        const MutliPickImageWidget(),
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
                    results.notes = text;
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
