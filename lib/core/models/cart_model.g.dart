// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    quantity: json['quantity'] as int,
    product: Product.fromJson(json['product'] as Map<String, dynamic>),
    price: (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
    };
