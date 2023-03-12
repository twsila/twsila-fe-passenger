import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/presentation/goods/furniture_view/result_widget.dart';
import 'package:taxi_for_you/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/utils/resources/color_manager.dart';

import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../google_maps/bloc/maps_bloc.dart';
import '../../google_maps/bloc/maps_events.dart';
import '../../google_maps/bloc/maps_state.dart';
import '../../google_maps/helpers/map_provider.dart';
import '../../google_maps/view/google_maps_widget.dart';
import '../../google_maps/view/google_search.dart';
import 'data_fields.dart';

class FurnitureView extends StatefulWidget {
  const FurnitureView({Key? key}) : super(key: key);

  @override
  State<FurnitureView> createState() => _FurnitureViewState();
}

class _FurnitureViewState extends State<FurnitureView> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  getCurrentLocation() async {
    BlocProvider.of<MapsBloc>(context).add(GetCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackButton(onPressed: () {
                        Provider.of<MapProvider>(context, listen: false)
                            .setSourceLocation(null);
                        Provider.of<MapProvider>(context, listen: false)
                            .setDestinationLocation(null);
                        Navigator.pop(context);
                      })),
                  Container(
                    height: context.getHeight() / 6,
                    margin: const EdgeInsets.all(16),
                    child: Center(child: Image.asset(ImageAssets.logoImg)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: BlocConsumer<MapsBloc, MapsState>(
                      listener: ((context, state) {
                        if (state is CurrentLocationFailed) {
                          ShowDialogHelper.showErrorMessage(
                              state.errorMessage, context);
                        }
                      }),
                      builder: ((context, state) {
                        if (state is CurrentLocationIsLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: ColorManager.primary,
                              color: Colors.blue,
                            ),
                          );
                        } else if (state is CurrentLocationLoadedSuccessfully) {
                          Provider.of<MapProvider>(context).currentLocation =
                              state.currentLocation;
                          return Column(
                            children: [
                              GoogleSearchScreen(),
                              const SizedBox(height: 16),
                              Expanded(child: GoogleMapsWidget()),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              GoogleSearchScreen(),
                              const SizedBox(height: 16),
                              Expanded(child: GoogleMapsWidget()),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                  const DataFieldsWidget(),
                  CustomTextButton(
                    text: 'تأكيد بيانات الرحلة',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ShowDialogHelper.showDialogPopupWithCancel(
                          'تأكيد بيانات الرحلة',
                          '',
                          context,
                          () => Navigator.pop(context), () {
                        ShowDialogHelper.showSuccessMessage(
                            'تم تأكيد الرحلة بنجاح', context);
                        Navigator.pop(context);
                      }, messageWidget: ResultsWidget());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
