import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_state.dart';

import '../../../../core/utils/resources/routes_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../common/state_renderer/dialogs.dart';
import '../../../common/widgets/custom_scaffold.dart';
import '../../../common/widgets/page_builder.dart';
import '../../common/common_views/pageview_widgets/transportation_top_widget.dart';
import 'goods_viewmodel.dart';

class GoodsView extends StatefulWidget {
  const GoodsView({Key? key}) : super(key: key);

  @override
  State<GoodsView> createState() => _GoodsViewState();
}

class _GoodsViewState extends State<GoodsView> {
  final GoodsViewModel _viewModel = GoodsViewModel();

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
    return BlocListener<TransportationBloc, TransportationRequestStates>(
        listener: (context, state) {
          if (state is TransportationRequestIsLoading) {
            setState(() {
              _viewModel.displayLoadingIndicator = true;
            });
          } else {
            setState(() {
              _viewModel.displayLoadingIndicator = false;
            });
          }
          if (state is TransportationRequestSuccessfully) {
            ShowDialogHelper.showSuccessMessage(
              AppStrings.tripConfirmationSucceeded.tr(),
              context,
            );
            Future.delayed(
                const Duration(seconds: 1),
                () => Navigator.popUntil(
                    context, ModalRoute.withName(Routes.homeRoute)));
          }
          if (state is TransportationRequestFailed) {
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
                        text: AppStrings.goodsTransportation.tr(),
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
