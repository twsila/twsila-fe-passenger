import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

class FetchDataException extends PlatformException {
  FetchDataException([String code = "Error001"])
      : super(message: "Error During Communication", code: code);
}

class BadRequestException extends HttpException {
  String message;
  String status;
  BadRequestException({required this.message, required this.status})
      : super(message);
}

class UnauthorisedException extends PlatformException {
  UnauthorisedException([String code = "Error003"])
      : super(message: "Unauthorised", code: code);
}

class InvalidInputException extends PlatformException {
  InvalidInputException([String code = "Error004"])
      : super(message: "Invalid Input", code: code);
}

class AppTimeOutException extends PlatformException {
  AppTimeOutException([String code = "Error005"])
      : super(message: AppStrings.noInternetError.tr(), code: code);
}

class NoInternetException extends PlatformException {
  NoInternetException([String code = "Error006"])
      : super(message: AppStrings.noInternetError.tr(), code: code);
}

class AuthenticationCancelledException extends PlatformException {
  AuthenticationCancelledException([String code = "AuthCancelled"])
      : super(message: "Authentication Cancelled", code: code);
}
