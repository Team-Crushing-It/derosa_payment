import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_payments_api/firestore_payments_api.dart';
import 'package:firestore_payments_api/models/models.dart';

part 'make_payment_event.dart';
part 'make_payment_state.dart';

class MakePaymentBloc extends Bloc<MakePaymentEvent, MakePaymentState> {
  MakePaymentBloc({
    required FirestorePaymentsApi firestorePaymentsApi,
    required this.payment,
    required this.userId,
  })  : _firestorePaymentsApi = firestorePaymentsApi,
        super(MakePaymentState.initial(userId, payment)) {
    on<DefaultSelected>(_onDefaultSelected);

    on<PaymentSuccess>(_onPaymentSuccess);
  }

  final FirestorePaymentsApi _firestorePaymentsApi;
  final String userId;
  final Payment payment;

  /// Event handler for the event when the default payment
  /// method is selected
  Future<void> _onDefaultSelected(
    DefaultSelected event,
    Emitter<MakePaymentState> emit,
  ) async {
    emit(
      state.copyWith(status: MakePaymentStatus.defaultPayment),
    );

    await _firestorePaymentsApi.savePayment(payment).then(
          (value) => {
            emit(
              state.copyWith(status: MakePaymentStatus.success),
            )
          },
        );
  }

  /// Event handler for the event when the default payment
  /// method is selected
  void _onPaymentSuccess(
    PaymentSuccess event,
    Emitter<MakePaymentState> emit,
  ) {
    emit(
      state.copyWith(status: MakePaymentStatus.success),
    );
  }
}
