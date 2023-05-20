import 'package:flutter/material.dart';

class PageBuilder {
  bool allowBackButtonInAppBar;
  bool appbar;
  bool enableDrawer;
  bool hasBackgroundImage;
  String? appBarTitle;
  GlobalKey<ScaffoldState> scaffoldKey;
  Widget body;
  BuildContext context;
  Function? backButtonCallBack;
  List<Widget>? appBarActions;
  bool displayLoadingIndicator;
  bool searchIcon;
  Function(String)? onSearchTapped;
  TextEditingController? searchController;
  VoidCallback? onSearchClosed;
  bool resizeToAvoidBottomInsets;
  String? searchHint;
  VoidCallback? onClearSearchQuery;
  Widget? floatingActionButton;
  Color? appBarBackgroundColor;
  Color? appBarActionsColor;
  Widget? appbarTitleWidget;
  bool? centerTitle;
  bool extendBodyBehindAppBar;
  double? elevation;
  String? screenTitle;
  bool? showAppLogoAtTheEnd;

  PageBuilder({
    this.appBarActions,
    this.showAppLogoAtTheEnd = false,
    this.enableDrawer = false,
    this.hasBackgroundImage = true,
    required this.scaffoldKey,
    this.backButtonCallBack,
    this.appBarTitle = "",
    this.appbar = true,
    required this.context,
    this.allowBackButtonInAppBar = true,
    required this.body,
    this.displayLoadingIndicator = false,
    this.searchIcon = false,
    this.extendBodyBehindAppBar = false,
    this.onSearchTapped,
    this.onSearchClosed,
    this.searchController,
    this.resizeToAvoidBottomInsets = true,
    this.searchHint,
    this.onClearSearchQuery,
    this.floatingActionButton,
    this.appBarBackgroundColor,
    this.appbarTitleWidget,
    this.appBarActionsColor,
    this.centerTitle,
    this.elevation,
    this.screenTitle,
  });
}
