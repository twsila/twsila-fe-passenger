import 'package:equatable/equatable.dart';

import '../models/freezers-model.dart';

class FreezersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendFreezersRequest extends FreezersEvent {
  final FreezersModel freezersModel;

  SendFreezersRequest({required this.freezersModel});
}
