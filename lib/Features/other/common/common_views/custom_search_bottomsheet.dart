import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_close_button.dart';
import 'package:taxi_for_you/Features/other/common/common_views/custom_maps_widget.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../google_maps/view/google_places_field.dart';

class CustomSearchBottomsheet extends StatefulWidget {
  final String title;
  final Function(String lat, String long, String locationName) onSelectPlace;

  const CustomSearchBottomsheet({
    Key? key,
    required this.title,
    required this.onSelectPlace,
  }) : super(key: key);
  @override
  _CustomSearchBottomsheetState createState() =>
      _CustomSearchBottomsheetState();
}

class _CustomSearchBottomsheetState extends State<CustomSearchBottomsheet> {
  final TextEditingController _searchController = TextEditingController();
  bool getLocationFromMap = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: !getLocationFromMap
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: getMediumStyle(
                            color: ColorManager.primaryTextColor),
                      ),
                      const CustomCloseButton(),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Column(
                    children: [
                      GoogleMapsPlacesField(
                        controller: _searchController,
                        focusNode: FocusNode(debugLabel: 'source_node'),
                        hintText: widget.title,
                        predictionCallback: (prediction) {
                          if (prediction != null) {
                            widget.onSelectPlace(
                              prediction.lat!,
                              prediction.lng!,
                              prediction.description!,
                            );
                            Navigator.pop(context);
                          } else {}
                        },
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getLocationFromMap = true;
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(ImageAssets.pin),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                AppStrings.selectLocationOnMap.tr(),
                                style: getBoldStyle(
                                    color: ColorManager.primaryTextColor,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: CustomMapsWidget(
                  title: widget.title,
                  onSelectLocation: (lat, long, locationName) {
                    widget.onSelectPlace(
                      lat,
                      long,
                      locationName,
                    );
                    Navigator.pop(context);
                  },
                  onBackPressed: () {
                    setState(() {
                      getLocationFromMap = false;
                    });
                  }),
            ),
    );
  }
}
