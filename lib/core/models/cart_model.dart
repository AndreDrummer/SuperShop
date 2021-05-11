import 'package:json_annotation/json_annotation.dart';
import 'package:supers/core/models/product_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartItem {
  CartItem({
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  CartItem copyWith({
    Product? newProduct,
    int? newQuantity,
  }) {
    return CartItem(
      quantity: newQuantity ?? quantity,
      product: newProduct ?? product,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
