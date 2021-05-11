import 'package:json_annotation/json_annotation.dart';
import 'package:supers/core/models/product_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class Cart {
  Cart({
    required this.product,
    required this.quantity,
    required this.price,
  });

  final Product product;
  final int quantity;
  final double price;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
