import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUser extends LoginEvent {
  final String mobileNumber;
  final BuildContext context;

  LoginUser({required this.mobileNumber, required this.context});
}
