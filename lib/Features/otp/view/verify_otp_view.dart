import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';

class VerifyOtpView extends StatefulWidget {
  VerifyOtpView({Key? key}) : super(key: key);

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey globalKey = GlobalKey();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  //   _viewModel.isCodeIsVerifiedStreamController.stream
  //       .listen((isCodeIsVerified) {
  //     if (isCodeIsVerified) {
  //       // navigate to main screen
  //       SchedulerBinding.instance.addPostFrameCallback((_) {
  //         if (_appPreferences
  //             .getUserDevice(_loginViewModel.loginObject.phoneNumber)) {
  //           _appPreferences.setUserLoggedIn();
  //           Navigator.of(context).pushReplacementNamed(Routes.categoriesRoute);
  //         } else {
  //           Navigator.of(context).pushReplacementNamed(Routes.registerRoute);
  //         }
  //       });
  //     }
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
