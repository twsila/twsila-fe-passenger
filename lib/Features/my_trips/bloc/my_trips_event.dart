import 'package:equatable/equatable.dart';

class MyTripsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserTrips extends MyTripsEvent {
  final int tripModelType;

  GetUserTrips({
    required this.tripModelType,
  });
}
