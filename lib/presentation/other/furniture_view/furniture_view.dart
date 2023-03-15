import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/presentation/other/furniture_view/furniture_viewmodel.dart';
import 'package:taxi_for_you/presentation/other/furniture_view/widgets/furniture_result_widget.dart';
import 'package:taxi_for_you/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/utils/resources/assets_manager.dart';

import '../../../utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../google_maps/view/google_search.dart';
import 'widgets/furniture_data_fields.dart';

class FurnitureView extends StatefulWidget {
  const FurnitureView({Key? key}) : super(key: key);

  @override
  State<FurnitureView> createState() => _FurnitureViewState();
}

class _FurnitureViewState extends State<FurnitureView> {
  final FurnitureViewModel furnitureViewModel = FurnitureViewModel();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    sourceController.addListener(() {
      furnitureViewModel.furnitureModel.sourceLocationString =
          sourceController.text;
    });
    destinationController.addListener(() {
      furnitureViewModel.furnitureModel.destinationLocationString =
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
                    text: AppStrings.furniture.tr(),
                  ),
                  Container(
                    height: context.getHeight() / 6,
                    margin: const EdgeInsets.all(16),
                    child: Center(child: Image.asset(ImageAssets.logoImg)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: GoogleSearchScreen(
                      sourceController: sourceController,
                      destinationController: destinationController,
                      onSelectSource: (source) => furnitureViewModel
                          .furnitureModel.sourceLocation = source,
                      onSelectDestination: (destination) => furnitureViewModel
                          .furnitureModel.destinationLocation = destination,
                      onSelectDate: (date) =>
                          furnitureViewModel.furnitureModel.date = date,
                    ),
                  ),
                  FurnitureDataFields(
                    furnitureModel: furnitureViewModel.furnitureModel,
                  ),
                  CustomTextButton(
                    text: AppStrings.tripConfirmation.tr(),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ShowDialogHelper.showDialogPopupWithCancel(
                          AppStrings.tripConfirmation.tr(),
                          '',
                          context,
                          () => Navigator.pop(context), () {
                        ShowDialogHelper.showSuccessMessage(
                            AppStrings.tripConfirmationSucceeded.tr(), context);
                        Navigator.pop(context);
                      },
                          messageWidget: FurnitureResultsWidget(
                            furnitureModel: furnitureViewModel.furnitureModel,
                          ));
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
