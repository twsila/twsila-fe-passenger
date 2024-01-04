import 'package:equatable/equatable.dart';

class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendPaymentRequest extends PaymentEvent {
  final String tripId;
  SendPaymentRequest({required this.tripId});
}
