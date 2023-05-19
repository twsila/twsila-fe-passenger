import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/common/custom_info_widgets.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import '../../common/custom_images_show.dart';
import '../../common/custom_payment_field_show.dart';
import '../../common/custom_private_notes_show.dart';
import '../models/furniture-model.dart';

class FurnitureResultsWidget extends StatelessWidget {
  final FurnitureModel furnitureModel;

  const FurnitureResultsWidget({Key? key, required this.furnitureModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (furnitureModel.date != null)
          CustomInfoStringWidget(
              info: AppStrings.scheduleAppoinment.tr(),
              text: furnitureModel.date),
        if (furnitureModel.sourceLocationString != null)
          CustomInfoStringWidget(
              info: AppStrings.sourcePoint.tr(),
              text: furnitureModel.sourceLocationString),
        if (furnitureModel.destinationLocationString != null)
          CustomInfoStringWidget(
              info: AppStrings.destinationPoint.tr(),
              text: furnitureModel.destinationLocationString),
        // SizedBox(
        //     height: 200,
        //     child: GoogleMapsWidget(
        //       sourceLocation: furnitureModel.sourceLocation,
        //       destinationLocation: furnitureModel.destinationLocation,
        //     )),
        Column(
          children: [
            CustomInfoBooleanWidget(
              booleanValue: furnitureModel.loadingBool,
              info: AppStrings.unloadAndLoad.tr(),
            ),
            CustomInfoBooleanWidget(
              booleanValue: furnitureModel.wrappingBool,
              info: AppStrings.wrapping.tr(),
            ),
            CustomInfoBooleanWidget(
              booleanValue: furnitureModel.assembleBool,
              info: AppStrings.assemble.tr(),
            ),
            CustomInfoBooleanWidget(
              booleanValue: furnitureModel.craneBool,
              info: AppStrings.crane.tr(),
            ),
            CustomInfoBooleanWidget(
              booleanValue: furnitureModel.assembleBool,
              info: AppStrings.assemble.tr(),
            ),
            CustomInfoBooleanWidget(
              booleanValue: furnitureModel.craneBool,
              info: AppStrings.crane.tr(),
            ),
            CustomInfoIntWidget(
              info: AppStrings.fridgeNumber.tr(),
              text: furnitureModel.fridgeNumber,
            ),
            CustomInfoIntWidget(
              info: AppStrings.carpetsNumber.tr(),
              text: furnitureModel.carpetsNumber,
            ),
            CustomInfoIntWidget(
              info: AppStrings.kitchenNumber.tr(),
              text: furnitureModel.kitchenNumber,
            ),
            CustomInfoIntWidget(
              info: AppStrings.bedNumber.tr(),
              text: furnitureModel.roomsNumber,
            ),
            CustomInfoIntWidget(
              info: AppStrings.sofaSet.tr(),
              text: furnitureModel.chairsNumber,
            ),
            CustomInfoIntWidget(
              info: AppStrings.airconditionarNumber.tr(),
              text: furnitureModel.airconditionerNumber,
            ),
            CustomInfoIntWidget(
              info: AppStrings.dinningRoomNumber.tr(),
              text: furnitureModel.diningRoomNumber,
            ),
            CustomShowImagesWidget(images: furnitureModel.images),
            CustomPrivateNotesShow(notes: furnitureModel.notes),
            CustomPaymentFieldShow(paymentValue: furnitureModel.paymentValue)
          ],
        )
      ],
    );
  }
}
