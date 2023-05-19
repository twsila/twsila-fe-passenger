import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/freezers_view/freezers_viewmodel.dart';
import 'package:taxi_for_you/Features/other/freezers_view/widgets/freezers_data_fields.dart';
import 'package:taxi_for_you/Features/other/freezers_view/widgets/freezers_result_widget.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';

import '../../../core/utils/resources/assets_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_back_button.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../google_maps/view/google_search.dart';

class FreezersView extends StatefulWidget {
  const FreezersView({Key? key}) : super(key: key);

  @override
  State<FreezersView> createState() => _FreezersViewState();
}

class _FreezersViewState extends State<FreezersView> {
  final FreezersViewModel freezersViewModel = FreezersViewModel();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  bool isValidType = true;
  bool isValidMaterial = true;

  @override
  void initState() {
    sourceController.addListener(() {
      freezersViewModel.freezersModel.sourceLocationString =
          sourceController.text;
    });
    destinationController.addListener(() {
      freezersViewModel.freezersModel.destinationLocationString =
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
                    text: AppStrings.freezers.tr(),
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
                        freezersViewModel.freezersModel.sourceLocation = source,
                    onSelectDestination: (destination) => freezersViewModel
                        .freezersModel.destinationLocation = destination,
                    onSelectDate: (date) =>
                        freezersViewModel.freezersModel.date = date,
                  ),
                  FreezersDataFields(
                    isValidType: isValidType,
                    isValidMaterial: isValidMaterial,
                    freezersViewModel: freezersViewModel,
                  ),
                  CustomTextButton(
                    text: AppStrings.tripConfirmation.tr(),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      freezersViewModel.freezersModel.shippedType == null
                          ? setState(() {
                              isValidType = false;
                            })
                          : setState(() {
                              isValidType = true;
                            });
                      freezersViewModel.freezersModel.shippedMaterial == null
                          ? setState(() {
                              isValidMaterial = false;
                            })
                          : setState(() {
                              isValidMaterial = true;
                            });

                      if (!isValidType || !isValidMaterial) return;
                      ShowDialogHelper.showDialogPopupWithCancel(
                          AppStrings.tripConfirmation.tr(),
                          '',
                          context,
                          () => Navigator.pop(context), () {
                        ShowDialogHelper.showSuccessMessage(
                            AppStrings.tripConfirmationSucceeded.tr(), context);
                        Navigator.pop(context);
                      },
                          messageWidget: FreezersResultsWidget(
                            freezersModel: freezersViewModel.freezersModel,
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
