// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String? ?? '',
      timeStamp: json['timeStamp'] as String? ?? 'DateTime.now().toString()',
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'timeStamp': instance.timeStamp,
    };
