import 'package:equatable/equatable.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';

class TransportationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendTransportationRequest extends TransportationEvent {
  final String endPoint;
  final TransportationBaseModel transportationBaseModel;
  final Map<String, dynamic> body;
  final List<XFile>? files;

  SendTransportationRequest({
    required this.endPoint,
    required this.transportationBaseModel,
    required this.body,
    this.files,
  });
}
