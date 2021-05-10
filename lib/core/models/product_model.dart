library products;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'product_model.g.dart';

abstract class Product implements Built<Product, ProductBuilder> {
  static Serializer<Product> get serializer => _$productSerializer;

  int get id;
  String get name;
  double get price;
  int get score;
  String get image;

  Product._();

  factory Product([Function(ProductBuilder b) updates]) = _$Product;
}
