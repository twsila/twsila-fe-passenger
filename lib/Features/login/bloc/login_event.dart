import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUser extends LoginEvent {
  final String mobileNumber;

  LoginUser({required this.mobileNumber});
}
