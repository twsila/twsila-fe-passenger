import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/other/car_aid_view/car_aid_viewmodel.dart';
import 'package:taxi_for_you/presentation/other/car_aid_view/widgets/car_aid_data_fields.dart';
import 'package:taxi_for_you/presentation/other/car_aid_view/widgets/car_aid_result_widget.dart';
import 'package:taxi_for_you/utils/ext/screen_size_ext.dart';

import '../../../utils/resources/assets_manager.dart';
import '../../../utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_back_button.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../google_maps/view/google_search.dart';

class CarAidView extends StatefulWidget {
  const CarAidView({Key? key}) : super(key: key);

  @override
  State<CarAidView> createState() => _CarAidViewState();
}

class _CarAidViewState extends State<CarAidView> {
  CarAidViewModel carAidViewModel = CarAidViewModel();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    sourceController.addListener(() {
      carAidViewModel.carAidModel.sourceLocationString = sourceController.text;
    });
    destinationController.addListener(() {
      carAidViewModel.carAidModel.destinationLocationString =
          destinationController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    sourceController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomBackButton(
                    onPressed: () => Navigator.pop(context),
                    text: AppStrings.carAid.tr(),
                  ),
                  Container(
                    height: context.getHeight() / 6,
                    margin: const EdgeInsets.all(16),
                    child: Center(child: Image.asset(ImageAssets.logoImg)),
                  ),
                  GoogleSearchScreen(
                    sourceController: sourceController,
                    destinationController: destinationController,
                    onSelectSource: (source) =>
                        carAidViewModel.carAidModel.sourceLocation = source,
                    onSelectDestination: (destination) => carAidViewModel
                        .carAidModel.destinationLocation = destination,
                    onSelectDate: (date) =>
                        carAidViewModel.carAidModel.date = date,
                  ),
                  CarAidDataField(carAidModel: carAidViewModel.carAidModel),
                  CustomTextButton(
                    text: AppStrings.tripConfirmation.tr(),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ShowDialogHelper.showDialogPopupWithCancel(
                        AppStrings.tripConfirmation.tr(),
                        '',
                        context,
                        () => Navigator.pop(context),
                        () {
                          ShowDialogHelper.showSuccessMessage(
                              AppStrings.tripConfirmationSucceeded.tr(),
                              context);
                          Navigator.pop(context);
                        },
                        messageWidget: CarAidResultWidget(
                          carAidModel: carAidViewModel.carAidModel,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
