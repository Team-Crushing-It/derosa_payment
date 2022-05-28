import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_payments_api/models/payment.dart';

/// {@template firestore_payments_api}
/// Firestore implementation for the Payments example
/// {@endtemplate}
class FirestorePaymentsApi{
  /// {@macro firestore_payments_api}
  FirestorePaymentsApi({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// a converter method for maintaining type-safety
  late final paymentsCollection =
      _firestore.collection('payments').withConverter<Payment>(
            fromFirestore: (snapshot, _) => Payment.fromJson(snapshot.data()!),
            toFirestore: (payment, _) => payment.toJson(),
          );

  /// This stream orders the [Payment]'s by the
  /// time they were created, and then converts
  /// them from a [DocumentSnapshot] into
  /// a [Payment]
  Stream<List<Payment>> getPayments() {
    return paymentsCollection.orderBy('id').snapshots().map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  /// This method first checks whether or not a payment exists
  /// If it doesn't, then we add a timestamp to the payment in
  /// order to preserve the order they were added
  /// Else, we update the existing one
  Future<void> savePayment(Payment payment) async {
    await paymentsCollection.add(payment);
  }

  /// This method first checks to see if the payment
  /// exists, and if so it deletes it
  // TODO(fix): check out dismissiable bug

  Future<void> deletePayment(String id) async {
    final check = await paymentsCollection.where('id', isEqualTo: id).get();

    if (check.docs.isEmpty) {
      throw PaymentNotFoundException();
    } else {
      final currentPaymentId = check.docs[0].reference.id;
      await paymentsCollection.doc(currentPaymentId).delete();
    }
  }



}


/// Error thrown when a [Payment] with a given id is not found.
class PaymentNotFoundException implements Exception {}
