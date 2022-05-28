part of 'make_payment_bloc.dart';

abstract class MakePaymentState extends Equatable {
  const MakePaymentState();
  
  @override
  List<Object> get props => [];
}

class MakePaymentInitial extends MakePaymentState {}

class MakePaymentInProgress extends MakePaymentState {}

class MakePaymentSuccesss extends MakePaymentState {}

class MakePaymentFailure extends MakePaymentState {}
