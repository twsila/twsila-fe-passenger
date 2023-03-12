import 'dart:io';

import 'package:flutter/material.dart';

import '../../google_maps/helpers/set_result.dart';
import '../../google_maps/view/google_maps_widget.dart';

class ResultsWidget extends StatelessWidget {
  final results = Results();
  ResultsWidget({Key? key}) : super(key: key);

  Widget infoLargeWidget(BuildContext context, String info, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            info,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget infoWidget(BuildContext context, String info, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            text,
            textAlign: TextAlign.end,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
          const SizedBox(width: 8),
          Text(
            info,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget infoBooleanWidget(
      BuildContext context, String info, bool booleanValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            booleanValue ? 'نعم' : 'لا',
            textAlign: TextAlign.end,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
          const SizedBox(width: 8),
          Text(
            info,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (results.date != null)
          infoLargeWidget(context, 'جدولة المواعيد', results.date!),
        if (results.sourceLocation != null)
          infoLargeWidget(context, 'نقطة الالتقاط', results.sourceLocation!),
        if (results.destinationLocation != null)
          infoLargeWidget(
              context, 'نقطة التوصيل', results.destinationLocation!),
        // SizedBox(height: 200, child: GoogleMapsWidget()),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      infoBooleanWidget(
                          context, 'فك و تركيب', results.assembleBool),
                      infoBooleanWidget(context, 'رافعة', results.craneBool),
                      infoWidget(
                          context,
                          'عدد الثلاجات',
                          results.fridgeNumber != null
                              ? results.fridgeNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'عدد السجاد',
                          results.carpetsNumber != null
                              ? results.carpetsNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'عدد مطبخ',
                          results.kitchenNumber != null
                              ? results.kitchenNumber.toString()
                              : 'لا يوجد'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      infoBooleanWidget(
                          context, 'تفريغ و تحميل', results.loadingBool),
                      infoBooleanWidget(context, 'تغليف', results.wrappingBool),
                      infoWidget(
                          context,
                          'عدد غرف النوم',
                          results.roomsNumber != null
                              ? results.roomsNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'طقم الكنب',
                          results.chairsNumber != null
                              ? results.chairsNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'عدد المكيفات',
                          results.airconditionerNumber != null
                              ? results.airconditionerNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'غرفة سفرة',
                          results.diningRoomNumber != null
                              ? results.diningRoomNumber.toString()
                              : 'لا يوجد'),
                    ],
                  )
                ],
              ),
            ),
            results.images != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الصور المرفقة',
                        textAlign: TextAlign.end,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18),
                      ),
                      Wrap(
                        children: results.images!.map((imageone) {
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
                : Container(),
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      results.notes ?? 'لا يوجد',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ملاحظات خاصة',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
