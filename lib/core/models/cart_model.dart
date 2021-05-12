import 'package:json_annotation/json_annotation.dart';
import 'package:supers/core/models/product_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartItem {
  CartItem({
    required this.quantity,
    required this.product,
    required this.price,
  });

  final Product product;
  final double price;
  final int quantity;

  CartItem copyWith({
    Product? newProduct,
    int? newQuantity,
    double? newPrice,
  }) {
    return CartItem(
      quantity: newQuantity ?? quantity,
      product: newProduct ?? product,
      price: newPrice ?? price,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
