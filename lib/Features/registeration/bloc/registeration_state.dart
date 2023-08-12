import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../core/network/base_response.dart';

class RegistrationStates extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationIsNotLoading extends RegistrationStates {}

class RegistrationIsLoading extends RegistrationStates {}

class RegistrationSuccessfully extends RegistrationStates {
  final UserModel _userModel;

  UserModel get userModel => _userModel;

  RegistrationSuccessfully(this._userModel);
  @override
  List<Object> get props => [userModel];
}

class RegistrationFailed extends RegistrationStates {
  final BaseResponse baseResponse;

  RegistrationFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}

class EditUserSuccessfully extends RegistrationStates {
  final UserModel _userModel;

  UserModel get userModel => _userModel;

  EditUserSuccessfully(this._userModel);
  @override
  List<Object> get props => [userModel];
}

class EditUserFailed extends RegistrationStates {
  final BaseResponse baseResponse;

  EditUserFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
