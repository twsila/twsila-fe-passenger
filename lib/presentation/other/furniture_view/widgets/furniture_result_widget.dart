import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../domain/model/furniture-model.dart';
import '../../../google_maps/view/google_maps_widget.dart';

class FurnitureResultsWidget extends StatelessWidget {
  final FurnitureModel furnitureModel;

  const FurnitureResultsWidget({Key? key, required this.furnitureModel})
      : super(key: key);

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
        if (furnitureModel.date != null)
          infoLargeWidget(context, 'جدولة المواعيد', furnitureModel.date!),
        if (furnitureModel.sourceLocationString != null)
          infoLargeWidget(
              context, 'نقطة الالتقاط', furnitureModel.sourceLocationString!),
        if (furnitureModel.destinationLocationString != null)
          infoLargeWidget(context, 'نقطة التوصيل',
              furnitureModel.destinationLocationString!),
        // SizedBox(
        //     height: 200,
        //     child: GoogleMapsWidget(
        //       sourceLocation: furnitureModel.sourceLocation,
        //       destinationLocation: furnitureModel.destinationLocation,
        //     )),
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
                          context, 'فك و تركيب', furnitureModel.assembleBool),
                      infoBooleanWidget(
                          context, 'رافعة', furnitureModel.craneBool),
                      infoWidget(
                          context,
                          'عدد الثلاجات',
                          furnitureModel.fridgeNumber != null
                              ? furnitureModel.fridgeNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'عدد السجاد',
                          furnitureModel.carpetsNumber != null
                              ? furnitureModel.carpetsNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'عدد مطبخ',
                          furnitureModel.kitchenNumber != null
                              ? furnitureModel.kitchenNumber.toString()
                              : 'لا يوجد'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      infoBooleanWidget(
                          context, 'تفريغ و تحميل', furnitureModel.loadingBool),
                      infoBooleanWidget(
                          context, 'تغليف', furnitureModel.wrappingBool),
                      infoWidget(
                          context,
                          'عدد غرف النوم',
                          furnitureModel.roomsNumber != null
                              ? furnitureModel.roomsNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'طقم الكنب',
                          furnitureModel.chairsNumber != null
                              ? furnitureModel.chairsNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'عدد المكيفات',
                          furnitureModel.airconditionerNumber != null
                              ? furnitureModel.airconditionerNumber.toString()
                              : 'لا يوجد'),
                      infoWidget(
                          context,
                          'غرفة سفرة',
                          furnitureModel.diningRoomNumber != null
                              ? furnitureModel.diningRoomNumber.toString()
                              : 'لا يوجد'),
                    ],
                  )
                ],
              ),
            ),
            furnitureModel.images != null
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
                        children: furnitureModel.images!.map((imageone) {
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
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      furnitureModel.notes ?? 'لا يوجد',
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
