import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/Features/other/furniture_view/models/furniture_model.dart';

class FurnitureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendFurnitureRequest extends FurnitureEvent {
  final FurnitureModel furnitureModel;

  SendFurnitureRequest({required this.furnitureModel});
}
