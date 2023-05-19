import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../core/utils/resources/color_manager.dart';
import '../../core/utils/resources/routes_manager.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import '../common/widgets/custom_language_widget.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          // Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          _viewModel.dispose();
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Flexible(
                    flex: 1,
                    child: LanguageWidget(),
                  ),
                  Flexible(
                      flex: 2,
                      child: StreamBuilder<int>(
                          stream: _viewModel.outputPageController,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: snapshot.data == 0 ||
                                                snapshot.data == null
                                            ? ColorManager.primary
                                            : ColorManager.lightGrey,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: snapshot.data == 0 ||
                                                snapshot.data == null
                                            ? ColorManager.lightGrey
                                            : ColorManager.primary,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                  Flexible(flex: 1, child: Container())
                ],
              ),
              SizedBox(
                height: context.getHeight() / 16,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: _viewModel.widgets,
                  controller: _viewModel.pageController,
                ),
              )
            ],
          ),
        ));
  }
}
