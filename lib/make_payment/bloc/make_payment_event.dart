part of 'make_payment_bloc.dart';

abstract class MakePaymentEvent extends Equatable {
  const MakePaymentEvent();

  @override
  List<Object> get props => [];
}

class Initalized extends MakePaymentEvent {}

class DefaultSelected extends MakePaymentEvent {}

class PaymentSuccess extends MakePaymentEvent {}
