// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    shippingValue: (json['shippingValue'] as num).toDouble(),
    total: (json['total'] as num).toDouble(),
    items: (json['items'] as List<dynamic>)
        .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    date: DateTime.parse(json['date'] as String),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'items': instance.items,
      'shippingValue': instance.shippingValue,
      'date': instance.date.toIso8601String(),
      'total': instance.total,
      'id': instance.id,
    };
