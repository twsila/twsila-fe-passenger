import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import '../../../core/utils/location/map_provider.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_circular_indicator.dart';
import '../bloc/maps_bloc.dart';
import '../bloc/maps_events.dart';
import '../bloc/maps_state.dart';
import '../model/location_model.dart';

class GoogleMapsWidget extends StatefulWidget {
  final LocationModel? sourceLocation;
  final LocationModel? destinationLocation;
  final TextEditingController sourceController;
  final Function(LocationModel? source) onSelectSource;

  GoogleMapsWidget({
    Key? key,
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceController,
    required this.onSelectSource,
  }) : super(key: key);

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  bool _isInit = true;
  LocationModel? currentLocation;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition position = const CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 16.5,
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;

      setMapController(false);
    }
    super.didChangeDependencies();
  }

  setMapController(bool setFromCurrent) async {
    Provider.of<MapProvider>(context, listen: false).controller =
        await _controller.future;
    currentLocation =
        Provider.of<MapProvider>(context, listen: false).currentLocation;
    if ((widget.sourceLocation == null || setFromCurrent) &&
        currentLocation != null) {
      Provider.of<MapProvider>(context, listen: false).setLocation(
          sourceLocation: currentLocation,
          destinationLocation: widget.destinationLocation,
          removeOldPlace: widget.sourceLocation != null);
      widget.sourceController.text = currentLocation!.locationName;
      widget.onSelectSource(currentLocation);
    } else {
      Provider.of<MapProvider>(context, listen: false).setLocation(
        sourceLocation: widget.sourceLocation,
        destinationLocation: widget.destinationLocation,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, mapProvider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                  },
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer())
                  },
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: position,
                  markers: Set.from(mapProvider.markers),
                  polylines: Set<Polyline>.of(mapProvider.polylines.values),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: InkWell(
                      onTap: () {
                        BlocProvider.of<MapsBloc>(context, listen: false)
                            .add(GetCurrentLocation());
                      },
                      child: BlocConsumer<MapsBloc, MapsState>(
                        listener: ((context, state) {
                          if (state is CurrentLocationFailed) {
                            ShowDialogHelper.showErrorMessage(
                                state.errorMessage, context);
                          } else if (state
                              is CurrentLocationLoadedSuccessfully) {
                            Provider.of<MapProvider>(context, listen: false)
                                .currentLocation = state.currentLocation;
                            setMapController(true);
                          }
                        }),
                        builder: ((context, state) {
                          if (state is CurrentLocationIsLoading) {
                            return const CustomCircularProgressIndicator();
                          }
                          return Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: ColorManager.darkPrimary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            child: Icon(
                              Icons.location_searching,
                              size: 16,
                              color: ColorManager.white,
                            ),
                          );
                        }),
                      )),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (mapProvider.distance != null)
            Text('Distance: ${mapProvider.distance}'),
        ],
      );
    });
  }
}
