import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

class RegistrationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationUser extends RegistrationEvent {
  final UserModel userModel;

  RegistrationUser({required this.userModel});
}

class EditUser extends RegistrationEvent {
  final UserModel userModel;

  EditUser({required this.userModel});
}
