import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/goods-model.dart';

import '../../../google_maps/view/google_maps_widget.dart';

class GoodsResultsWidget extends StatelessWidget {
  final GoodsModel goodsModel;

  const GoodsResultsWidget({Key? key, required this.goodsModel})
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
        if (goodsModel.date != null)
          infoLargeWidget(context, 'جدولة المواعيد', goodsModel.date!),
        if (goodsModel.sourceLocationString != null)
          infoLargeWidget(
              context, 'نقطة الالتقاط', goodsModel.sourceLocationString!),
        if (goodsModel.destinationLocationString != null)
          infoLargeWidget(
              context, 'نقطة التوصيل', goodsModel.destinationLocationString!),
        // SizedBox(
        //     height: 200,
        //     child: GoogleMapsWidget(
        //       sourceLocation: goodsModel.sourceLocation,
        //       destinationLocation: goodsModel.destinationLocation,
        //     )),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoBooleanWidget(context, 'رافعة', goodsModel.craneBool),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      infoBooleanWidget(
                          context, 'تفريغ و تحميل', goodsModel.loadingBool),
                      infoBooleanWidget(
                          context, 'تغليف', goodsModel.wrappingBool),
                      infoWidget(
                          context,
                          'وزن البضاعة / طن',
                          goodsModel.goodsWeight != null
                              ? goodsModel.goodsWeight.toString()
                              : 'لا يوجد'),
                    ],
                  )
                ],
              ),
            ),
            goodsModel.images != null
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
                        children: goodsModel.images!.map((imageone) {
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
                      goodsModel.notes ?? 'لا يوجد',
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
