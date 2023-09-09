import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../../app/constants.dart';
import '../../../../../transportation_requests/view/transport_request_view.dart';

class PeopleTransportationWidget extends StatelessWidget {
  const PeopleTransportationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersonsModel personsModel = PersonsModel();
        personsModel.tripType = TripTypeConstants.personType;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransportRequestScreen(
              transportationBaseModel: personsModel,
              hasImages: false,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(134, 221, 250, 0.3),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.peopleVehicle.tr(),
              style: getBoldStyle(
                  color: ColorManager.primaryTextColor, fontSize: 16),
            ),
            Image.asset(ImageAssets.carPeople)
          ],
        ),
      ),
    );
  }
}
