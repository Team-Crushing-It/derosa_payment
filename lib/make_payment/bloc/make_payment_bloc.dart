import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'make_payment_event.dart';
part 'make_payment_state.dart';

class MakePaymentBloc extends Bloc<MakePaymentEvent, MakePaymentState> {
  MakePaymentBloc() : super(MakePaymentInitial()) {
    on<MakePaymentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
