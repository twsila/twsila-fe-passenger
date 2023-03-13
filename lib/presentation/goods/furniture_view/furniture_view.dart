import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/presentation/goods/furniture_view/furniture_viewmodel.dart';
import 'package:taxi_for_you/presentation/goods/furniture_view/widgets/result_widget.dart';
import 'package:taxi_for_you/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/utils/resources/assets_manager.dart';

import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../google_maps/view/google_search.dart';
import 'widgets/data_fields.dart';

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
      furnitureViewModel.furnitureModel.sourceLocation = sourceController.text;
    });
    destinationController.addListener(() {
      furnitureViewModel.furnitureModel.destinationLocation =
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
            margin: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackButton(onPressed: () {
                        Navigator.pop(context);
                      })),
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
                      onSelectDate: (date) =>
                          furnitureViewModel.furnitureModel.date,
                    ),
                  ),
                  DataFieldsWidget(
                    furnitureModel: furnitureViewModel.furnitureModel,
                  ),
                  CustomTextButton(
                    text: 'تأكيد بيانات الرحلة',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ShowDialogHelper.showDialogPopupWithCancel(
                          'تأكيد بيانات الرحلة',
                          '',
                          context,
                          () => Navigator.pop(context), () {
                        ShowDialogHelper.showSuccessMessage(
                            'تم تأكيد الرحلة بنجاح', context);
                        Navigator.pop(context);
                      },
                          messageWidget: ResultsWidget(
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
