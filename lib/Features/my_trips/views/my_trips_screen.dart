import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/my_trips/bloc/my_trips_state.dart';
import 'package:taxi_for_you/Features/my_trips/views/my_trips_viewmodel.dart';
import 'package:taxi_for_you/Features/my_trips/views/widgets/my_trips_widget.dart';
import 'package:taxi_for_you/Features/my_trips/views/widgets/toggle_widget.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../trip_details/view/trip_details_screen.dart';
import '../bloc/my_trips_bloc.dart';
import '../bloc/my_trips_event.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({Key? key}) : super(key: key);

  @override
  _MyTripsScreenState createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  final MyTripsViewModel _viewModel = MyTripsViewModel();

  @override
  void initState() {
    BlocProvider.of<MyTripsBloc>(context)
        .add(GetUserTrips(tripModelType: _viewModel.upcomingTripType));
    super.initState();
  }

  Future refresh() async {
    _viewModel.selectedIndex == 0
        ? BlocProvider.of<MyTripsBloc>(context)
            .add(GetUserTrips(tripModelType: _viewModel.upcomingTripType))
        : BlocProvider.of<MyTripsBloc>(context)
            .add(GetUserTrips(tripModelType: _viewModel.pastTripType));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        allowBackButtonInAppBar: false,
        scaffoldKey: _viewModel.scaffoldKey,
        displayLoadingIndicator: _viewModel.displayLoadingIndicator,
        context: context,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
              child: Text(
                AppStrings.myTrips.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorManager.black, fontWeight: FontWeight.w900),
              ),
            ),
            TripsToggleWidget(
              viewModel: _viewModel,
              onPressed: (index) {
                setState(() {
                  _viewModel.selections = List.generate(2, (index) => false);
                  _viewModel.selections[index] = true;
                  _viewModel.selectedIndex = index;
                  refresh();
                });
              },
            ),
            const SizedBox(height: 8),
            BlocConsumer<MyTripsBloc, MyTripsStates>(
              listener: (context, state) {
                if (state is MyTripsIsLoading) {
                  setState(() {
                    _viewModel.displayLoadingIndicator = true;
                  });
                } else {
                  setState(() {
                    _viewModel.displayLoadingIndicator = false;
                  });
                }
              },
              builder: (context, state) {
                if (state is MyTripsSuccessfully) {
                  return state.trips.isEmpty
                      ? Center(
                          child: Text(
                            _viewModel.selectedIndex == 0
                                ? AppStrings.noUpcoming.tr()
                                : AppStrings.noPast.tr(),
                          ),
                        )
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.trips.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TripDetailsScreen(
                                          tripId: state
                                              .trips[index].tripDetails.tripId!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: MyTripsWidget(
                                    tripModel: state.trips[index].tripDetails,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
