import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/profile/views/profile_screen.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/helpers/home_icons.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  AppPreferences appPreferences = instance<AppPreferences>();
  List<Widget> screens = [
    ProfileScreen(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
  ];

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
            appPreferences.logout(context);
          },
        );
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
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
            selectedIndex = index;
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
          index: selectedIndex,
          children: screens,
        ),
      ),
    );
  }
}
