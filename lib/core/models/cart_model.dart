library cart;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:supers/core/models/product_model.dart';

part 'cart_model.g.dart';

abstract class Cart implements Built<Cart, CartBuilder> {
  static Serializer<Cart> get serializer => _$cartSerializer;

  Product get product;
  int get quantity;
  double get price;

  Cart._();

  factory Cart([Function(CartBuilder b) updates]) = _$Cart;
}
