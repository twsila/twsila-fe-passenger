import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogoutUser extends HomeEvents {
  final BuildContext context;
  LogoutUser({required this.context});
}
