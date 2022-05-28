import 'package:equatable/equatable.dart';
import 'package:firestore_payments_api/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'payment.g.dart';

/// {@template payment}
/// A single payment item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Payment]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Payment extends Equatable {
  /// {@macro payment}
  const Payment({
    required this.id,
    required this.title,
    this.price = '',
    this.timeStamp= 'DateTime.now().toString()',
  });

  /// The unique identifier of the payment.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the payment.
  ///
  /// Note that the title may be empty.
  final String title;

  /// The price of the payment.
  ///
  /// Defaults to an empty string.
  final String price;

  /// Whether the payment is completed.
  ///
  /// Defaults to `now`.
  final String timeStamp;

  /// Returns a copy of this payment with the given values updated.
  ///
  /// {@macro payment}
  Payment copyWith({
    String? id,
    String? title,
    String? price,
    String? timeStamp
  }) {
    return Payment(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  /// Deserializes the given [JsonMap] into a [Payment].
  static Payment fromJson(JsonMap json) => _$PaymentFromJson(json);

  /// Converts this [Payment] into a [JsonMap].
  JsonMap toJson() => _$PaymentToJson(this);

  @override
  List<Object> get props => [id, title, price, timeStamp];
}
