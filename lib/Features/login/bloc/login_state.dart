import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../core/network/base_response.dart';

class LoginStates extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginIsNotLoading extends LoginStates {}

class LoginIsLoading extends LoginStates {}

class LoginSuccessfully extends LoginStates {
  final UserModel _userModel;

  UserModel get userModel => _userModel;

  LoginSuccessfully(this._userModel);
  @override
  List<Object> get props => [userModel];
}

class LoginFailed extends LoginStates {
  final BaseResponse baseResponse;

  LoginFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
