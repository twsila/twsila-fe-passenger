import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_third_view/widgets/third_view_widget.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/send_trip_request/send_trip_request_button.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../model/transportation_base_model.dart';
import '../../../transport_request_viewmodel.dart';

class TransportThirdView extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  final TransportRequestViewModel viewModel;
  final bool hasImages;

  const TransportThirdView({
    Key? key,
    required this.transportationBaseModel,
    required this.viewModel,
    required this.hasImages,
  }) : super(key: key);

  @override
  _TransportThirdViewState createState() => _TransportThirdViewState();
}

class _TransportThirdViewState extends State<TransportThirdView> {
  @override
  initState() {
    widget.viewModel.thirdScreenValid.value =
        widget.transportationBaseModel.paymentValue != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          hasImages: widget.hasImages,
          images: widget.transportationBaseModel.images,
          notes: widget.transportationBaseModel.notes,
          amount: widget.transportationBaseModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.transportationBaseModel.notes = notes;
            } else {
              widget.transportationBaseModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.transportationBaseModel.paymentValue =
                  double.parse(amount);
              widget.viewModel.thirdScreenValid.value = true;
            } else {
              widget.transportationBaseModel.paymentValue = null;
              widget.viewModel.thirdScreenValid.value = false;
            }
          },
          onSelectImage: (images) {
            widget.transportationBaseModel.images = images;
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, -7),
                )
              ],
            ),
            child: ValueListenableBuilder(
                valueListenable: widget.viewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return SendTripRequestButton(
                    transportationBaseModel: widget.transportationBaseModel,
                    value: value,
                  );
                }),
          ),
        ),
      ],
    );
  }
}
