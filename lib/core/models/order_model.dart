import 'package:json_annotation/json_annotation.dart';

import 'cart_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class Order {
  Order({
    required this.shippingValue,
    required this.total,
    required this.items,
    required this.date,
    required this.id,
  });

  final List<CartItem> items;
  final double shippingValue;
  final DateTime date;
  final double total;
  final int id;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
