import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUser extends LoginEvent {
  final String mobileNumber;

  LoginUser({required this.mobileNumber});
}
