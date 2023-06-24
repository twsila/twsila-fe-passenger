import 'package:equatable/equatable.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class TransportationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendTransportationRequest extends TransportationEvent {
  final String endPoint;
  final Map<String, dynamic> body;
  final List<XFile>? files;

  SendTransportationRequest({
    required this.endPoint,
    required this.body,
    this.files,
  });
}
