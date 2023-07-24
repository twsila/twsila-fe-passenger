import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/home/bloc/home_bloc.dart';
import 'package:taxi_for_you/Features/home/bloc/home_event.dart';
import 'package:taxi_for_you/Features/home/bloc/home_state.dart';
import 'package:taxi_for_you/Features/home/views/home_viewmodel.dart';
import 'package:taxi_for_you/core/utils/helpers/home_icons.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../common/state_renderer/easy_loader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ShowDialogHelper.showDialogPopupWithCancel(
          AppStrings.confirmation.tr(),
          AppStrings.logoutConfirmation.tr(),
          context,
          () => Navigator.pop(context),
          () {
            Navigator.pop(context);
            BlocProvider.of<HomeBloc>(context)
                .add(LogoutUser(context: context));
          },
        );
        return true;
      },
      child: BlocConsumer<HomeBloc, HomeStates>(listener: (context, state) {
        if (state is LogoutIsLoading) {
          viewModel.displayLoadingIndicator = true;
        } else {
          viewModel.displayLoadingIndicator = false;
          if (state is LogoutFailed) {
            ShowDialogHelper.showErrorMessage(
                state.baseResponse.errorMessage ??
                    AppStrings.somethingWentWrong.tr(),
                context);
          }
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: viewModel.selectedIndex,
                backgroundColor: ColorManager.primaryTextColor,
                selectedItemColor: Colors.white,
                unselectedItemColor: ColorManager.bottomNavUnselected,
                selectedLabelStyle: getBoldStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                unselectedLabelStyle: getMediumStyle(
                  color: ColorManager.bottomNavUnselected,
                  fontSize: 12,
                ),
                onTap: (index) => setState(() {
                  viewModel.selectedIndex = index;
                }),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 2, 4),
                      child: Icon(HomeIcons.profile),
                    ),
                    label: AppStrings.profile.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 8, 4),
                      child: Icon(HomeIcons.card),
                    ),
                    label: AppStrings.requestService.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                      child: Icon(HomeIcons.myTrips),
                    ),
                    label: AppStrings.myTrips.tr(),
                  ),
                ],
              ),
              body: IndexedStack(
                index: viewModel.selectedIndex,
                children: viewModel.screens,
              ),
            ),
            if (viewModel.displayLoadingIndicator) const EasyLoader(),
          ],
        );
      }),
    );
  }
}
