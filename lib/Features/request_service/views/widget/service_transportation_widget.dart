import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/request_service/views/request_service_viewmodel.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/styles_manager.dart';

class ServiceTransportationWidget extends StatelessWidget {
  final ServiceTransportationModel serviceItem;

  const ServiceTransportationWidget({Key? key, required this.serviceItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: serviceItem.onPressed(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: serviceItem.color,
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(serviceItem.imageAsset),
            const SizedBox(height: 16),
            Text(
              serviceItem.text,
              style: getBoldStyle(
                color: ColorManager.primaryTextColor,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
