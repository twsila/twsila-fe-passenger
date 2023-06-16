import 'package:equatable/equatable.dart';

class TransportationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendTransportationRequest extends TransportationEvent {
  final String endPoint;
  final Map<String, dynamic> body;

  SendTransportationRequest({required this.endPoint, required this.body});
}
