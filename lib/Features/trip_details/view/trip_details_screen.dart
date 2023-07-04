import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/trip_details/view/trip_details_viewmodel.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/drivers_list_widget/drivers_list_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_details_widget/trip_details_widget.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/trip_type.dart';

class TripDetailsScreen extends StatefulWidget {
  final int tripId;
  const TripDetailsScreen({
    Key? key,
    required this.tripId,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final TripDetailsViewModel _viewModel = TripDetailsViewModel();

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
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: _viewModel.scaffoldKey,
        context: context,
        displayLoadingIndicator: _viewModel.displayLoadingIndicator,
        appBarTitle: AppStrings.tripDetails.tr(),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TripDetailsWidget(tripType: TripType.furniture),
                const SizedBox(height: 16),
                Divider(color: ColorManager.grey1),
                const DriversListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
