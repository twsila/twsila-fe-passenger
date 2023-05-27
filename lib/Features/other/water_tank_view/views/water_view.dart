import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/water_tank_view/views/water_viewmodel.dart';
import 'package:taxi_for_you/Features/other/water_tank_view/views/widgets/water_data_fields.dart';
import 'package:taxi_for_you/Features/other/water_tank_view/views/widgets/water_result_widget.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';

import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../common/state_renderer/dialogs.dart';
import '../../../common/widgets/custom_back_button.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../google_maps/view/google_search.dart';

class WaterTankView extends StatefulWidget {
  const WaterTankView({Key? key}) : super(key: key);

  @override
  State<WaterTankView> createState() => _WaterTankViewState();
}

class _WaterTankViewState extends State<WaterTankView> {
  bool isValidWeight = true;
  WaterTankViewModel waterTankViewModel = WaterTankViewModel();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    sourceController.addListener(() {
      waterTankViewModel.waterTankModel.sourceLocationString =
          sourceController.text;
    });
    destinationController.addListener(() {
      waterTankViewModel.waterTankModel.destinationLocationString =
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
                    text: AppStrings.waterTank.tr(),
                  ),
                  Container(
                    height: context.getHeight() / 6,
                    margin: const EdgeInsets.all(16),
                    child: Center(child: Image.asset(ImageAssets.logoImg)),
                  ),
                  GoogleSearchScreen(
                    sourceController: sourceController,
                    destinationController: destinationController,
                    onSelectSource: (source) => waterTankViewModel
                        .waterTankModel.sourceLocation = source,
                    onSelectDestination: (destination) => waterTankViewModel
                        .waterTankModel.destinationLocation = destination,
                    onSelectDate: (date, dateTime) =>
                        waterTankViewModel.waterTankModel.date = date,
                  ),
                  WaterTankDataField(
                    waterTankViewModel: waterTankViewModel,
                    isValidWeight: isValidWeight,
                  ),
                  CustomTextButton(
                    text: AppStrings.tripConfirmation.tr(),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      waterTankViewModel.waterTankModel.tankWeight == null
                          ? setState(() {
                              isValidWeight = false;
                            })
                          : setState(() {
                              isValidWeight = true;
                            });
                      if (!isValidWeight) return;
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
                        messageWidget: WaterTankResultWidget(
                          waterTankModel: waterTankViewModel.waterTankModel,
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
