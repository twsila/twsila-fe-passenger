import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';

import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/other/furniture_view/bloc/furniture_bloc.dart';
import 'package:taxi_for_you/Features/other/furniture_view/bloc/furniture_state.dart';
import 'package:taxi_for_you/Features/other/common/pageview_widgets/transportation_top_widget.dart';
import 'package:taxi_for_you/core/utils/resources/routes_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'furniture_viewmodel.dart';

class FurnitureScreen extends StatefulWidget {
  const FurnitureScreen({Key? key}) : super(key: key);

  @override
  State<FurnitureScreen> createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  final FurnitureViewModel _viewModel = FurnitureViewModel();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FurnitureBloc, FurnitureRequestStates>(
        listener: (context, state) {
          if (state is FurnitureRequestIsLoading) {
            setState(() {
              _viewModel.displayLoadingIndicator = true;
            });
          } else {
            setState(() {
              _viewModel.displayLoadingIndicator = false;
            });
          }
          if (state is FurnitureRequestSuccessfully) {
            ShowDialogHelper.showSuccessMessage(
              AppStrings.tripConfirmationSucceeded.tr(),
              context,
            );
            Future.delayed(
                const Duration(seconds: 1),
                () => Navigator.popUntil(
                    context, ModalRoute.withName(Routes.homeRoute)));
          }
          if (state is FurnitureRequestFailed) {
            ShowDialogHelper.showErrorMessage(
              state.baseResponse.errorMessage ?? 'Something went wrong',
              context,
            );
          }
        },
        child: CustomScaffold(
          pageBuilder: PageBuilder(
            scaffoldKey: _viewModel.scaffoldKey,
            displayLoadingIndicator: _viewModel.displayLoadingIndicator,
            allowBackButtonInAppBar: false,
            context: context,
            body: ValueListenableBuilder<int>(
                valueListenable: _viewModel.selectedIndex,
                builder: (BuildContext context, int selectedIndex, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TransportationTopWidget(
                        text: AppStrings.furnitureTransportation.tr(),
                        controller: _viewModel.controller,
                        selectedIndex: _viewModel.selectedIndex.value,
                        noOfScreens: _viewModel.screens.length,
                      ),
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _viewModel.controller,
                          children: _viewModel.screens,
                          onPageChanged: (value) =>
                              _viewModel.selectedIndex.value = value,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ));
  }
}
