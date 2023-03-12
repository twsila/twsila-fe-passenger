import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_date_picker.dart';

import '../helpers/map_provider.dart';
import '../model/location_model.dart';
import 'google_places_field.dart';

class GoogleSearchScreen extends StatefulWidget {
  GoogleSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleSearchScreen> createState() => GoogleSearchScreenState();
}

class GoogleSearchScreenState extends State<GoogleSearchScreen> {
  bool _isInit = true;
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      LocationModel? currentLocation =
          Provider.of<MapProvider>(context, listen: false).currentLocation;
      if (currentLocation != null) {
        sourceController.text = currentLocation.locationName;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDatePickerWidget(),
        Row(
          children: [
            Expanded(
              child: GoogleMapsPlacesField(
                controller: sourceController,
                focusNode: FocusNode(debugLabel: 'source_node'),
                hintText: 'Enter Source Location...',
                predictionCallback: (prediction) {
                  if (prediction != null) {
                    LocationModel sourceLocation = LocationModel(
                      locationName: prediction.description!,
                      latitude: double.parse(prediction.lat!),
                      longitude: double.parse(prediction.lng!),
                    );
                    Provider.of<MapProvider>(context, listen: false)
                        .setSourceLocation(sourceLocation);
                  } else {
                    Provider.of<MapProvider>(context, listen: false)
                        .setSourceLocation(null);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'نقطة الالتقاط',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GoogleMapsPlacesField(
                controller: destinationController,
                focusNode: FocusNode(debugLabel: 'destination_node'),
                hintText: 'Enter Destination Location...',
                predictionCallback: (prediction) {
                  if (prediction != null) {
                    LocationModel destinationLocation = LocationModel(
                      locationName: prediction.description!,
                      latitude: double.parse(prediction.lat!),
                      longitude: double.parse(prediction.lng!),
                    );
                    Provider.of<MapProvider>(context, listen: false)
                        .setDestinationLocation(destinationLocation);
                  } else {
                    Provider.of<MapProvider>(context, listen: false)
                        .setDestinationLocation(null);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'نقطة التوصيل',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ],
    );
  }
}
