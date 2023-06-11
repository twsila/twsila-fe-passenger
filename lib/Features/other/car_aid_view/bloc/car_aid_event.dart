import 'package:equatable/equatable.dart';

import '../models/car-aid-model.dart';

class CarAidEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendCarAidRequest extends CarAidEvent {
  final CarAidModel carAidModel;

  SendCarAidRequest({required this.carAidModel});
}
