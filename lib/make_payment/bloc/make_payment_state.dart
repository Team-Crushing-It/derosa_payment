part of 'make_payment_bloc.dart';

enum MakePaymentStatus {initial, defaultPayment, inProgress, success }

class MakePaymentState extends Equatable {
  const MakePaymentState._({
    required this.status,
    required this.payment,
    required this.userId,
  });

  const MakePaymentState.initial(String userId, Payment payment)
      : this._(
          status: MakePaymentStatus.initial,
          userId: userId,
          payment: payment,
        );

  const MakePaymentState.inProgress(String userId, Payment payment)
      : this._(
          status: MakePaymentStatus.inProgress,
          userId: userId,
          payment: payment,
        );

  const MakePaymentState.success(String userId, Payment payment)
      : this._(
          status: MakePaymentStatus.success,
          userId: userId,
          payment: payment,
        );

  final MakePaymentStatus status;
  final Payment payment;
  final String userId;

  @override
  List<Object> get props => [status, payment, userId];

  MakePaymentState copyWith({
    MakePaymentStatus? status,
    Payment? payment,
  }) {
    return MakePaymentState._(
      status: status ?? this.status,
      payment: payment ?? this.payment,
      userId: userId,
    );
  }
}
