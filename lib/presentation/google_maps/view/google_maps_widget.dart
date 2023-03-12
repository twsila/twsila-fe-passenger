import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../helpers/map_provider.dart';
import '../model/location_model.dart';

class GoogleMapsWidget extends StatefulWidget {
  GoogleMapsWidget({Key? key}) : super(key: key);

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  bool _isInit = true;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  CameraPosition position = const CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 16.5,
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;

      setMapController();
    }
    super.didChangeDependencies();
  }

  setMapController() async {
    Provider.of<MapProvider>(context, listen: false).controller =
        await _controller.future;
    LocationModel? currentLocation =
        Provider.of<MapProvider>(context, listen: false).currentLocation;
    var sourceController =
        Provider.of<MapProvider>(context, listen: false).sourceLocation;
    if (sourceController == null) {
      Provider.of<MapProvider>(context, listen: false)
          .setSourceLocation(currentLocation);
    } else {
      Provider.of<MapProvider>(context, listen: false)
          .setSourceLocation(sourceController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, mapProvider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) async {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                } else {
                  _controller = Completer<GoogleMapController>();
                }
              },
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: position,
              markers: Set.from(mapProvider.markers),
              polylines: Set<Polyline>.of(mapProvider.polylines.values),
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
