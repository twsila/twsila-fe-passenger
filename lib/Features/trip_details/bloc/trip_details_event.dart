import 'package:equatable/equatable.dart';

class TripDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTripDetailsRequest extends TripDetailsEvent {
  final int tripId;

  GetTripDetailsRequest({
    required this.tripId,
  });
}
