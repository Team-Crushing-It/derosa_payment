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
  @override
  Stream<List<Payment>> getPayments() {
    return paymentsCollection.orderBy('id').snapshots().map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  /// This method first checks whether or not a payment exists
  /// If it doesn't, then we add a timestamp to the payment in
  /// order to preserve the order they were added
  /// Else, we update the existing one
  @override
  Future<void> savePayment(Payment payment) async {
    final check = await paymentsCollection.where('id', isEqualTo: payment.id).get();

    if (check.docs.isEmpty) {
      // final output =
      //     payment.copyWith(id: Timestamp.now().millisecondsSinceEpoch.toString());
      await paymentsCollection.add(payment);
    } else {
      final currentPaymentId = check.docs[0].reference.id;
      await paymentsCollection.doc(currentPaymentId).update(payment.toJson());
    }
  }

  /// This method first checks to see if the payment
  /// exists, and if so it deletes it
  // TODO(fix): check out dismissiable bug

  @override
  Future<void> deletePayment(String id) async {
    final check = await paymentsCollection.where('id', isEqualTo: id).get();

    if (check.docs.isEmpty) {
      throw PaymentNotFoundException();
    } else {
      final currentPaymentId = check.docs[0].reference.id;
      await paymentsCollection.doc(currentPaymentId).delete();
    }
  }

  /// This method uses the Batch write api for
  /// executing multiple operations in a single call,
  /// which in this case is to delete all the payments that
  /// are marked completed
  @override
  Future<int> clearCompleted() {
    final batch = _firestore.batch();
    return paymentsCollection
        .where('isCompleted', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      final completedPaymentsAmount = querySnapshot.docs.length;
      for (final document in querySnapshot.docs) {
        batch.delete(document.reference);
      }
      batch.commit();
      return completedPaymentsAmount;
    });
  }

  /// This method uses the Batch write api for
  /// executing multiple operations in a single call,
  /// which in this case is to mark all the payments as
  /// completed
  @override
  Future<int> completeAll({required bool isCompleted}) {
    final batch = _firestore.batch();
    return paymentsCollection.get().then((querySnapshot) {
      final completedPaymentsAmount = querySnapshot.docs.length;
      for (final document in querySnapshot.docs) {
        final completedPayment = document.data().copyWith(isCompleted: true);
        batch.update(document.reference, completedPayment.toJson());
      }
      batch.commit();
      return completedPaymentsAmount;
    });
  }
}


/// Error thrown when a [Payment] with a given id is not found.
class PaymentNotFoundException implements Exception {}
