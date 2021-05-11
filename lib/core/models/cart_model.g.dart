// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    product: Product.fromJson(json['product'] as Map<String, dynamic>),
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
    };
