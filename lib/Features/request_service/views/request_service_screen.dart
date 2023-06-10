import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/request_service/views/request_service_viewmodel.dart';
import 'package:taxi_for_you/Features/request_service/views/widget/about_tawsela_widget.dart';
import 'package:taxi_for_you/Features/request_service/views/widget/service_transportation_widget.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../core/utils/resources/strings_manager.dart';
import '../../people_transportation/views/widgets/people_transportation_widget.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({Key? key}) : super(key: key);

  @override
  _RequestServiceScreenState createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final RequestServiceViewModel _viewModel = RequestServiceViewModel();

  @override
  void initState() {
    _viewModel.context = context;
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
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: _viewModel.scaffoldKey,
        context: context,
        allowBackButtonInAppBar: false,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AboutTawsela(),
                Row(
                  children: [
                    Text(
                      AppStrings.welcome.tr() + ' ',
                      style: getMediumStyle(
                        color: ColorManager.primaryTextColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _viewModel.userModel.firstName! +
                          ' ' +
                          _viewModel.userModel.lastName!,
                      style: getMediumStyle(
                        color: ColorManager.primaryTextColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    AppStrings.whatSearch.tr(),
                    style: getBoldStyle(
                      color: ColorManager.primaryTextColor,
                      fontSize: 24,
                    ),
                  ),
                ),
                const PeopleTransportationWidget(),
                const SizedBox(height: 16),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 20,
                  children: List.generate(
                      _viewModel.servicesList.length,
                      (index) => ServiceTransportationWidget(
                          serviceItem: _viewModel.servicesList[index])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
