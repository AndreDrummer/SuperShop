import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../data/dummy_data.dart';
import '../models/product_model.dart';
import '../serializer/serializers.dart';

class ProductsBloc extends ChangeNotifier {
  final products =
      BehaviorSubject<BuiltList<Product>>.seeded(BuiltList<Product>());

  void Function(BuiltList<Product>) get changeProduct => products.sink.add;
  Stream<BuiltList<Product>> get productsStream => products.stream;
  BuiltList<Product> get productList => products.value;

  void loadProducts() {
    changeProduct(BuiltList<Product>());
    final BuiltList<Product> products = BuiltList<Product>(
      productsGame.map(
        (product) => serializers.deserializeWith(
          Product.serializer,
          product,
        ),
      ),
    );

    changeProduct(products);
    // notifyListeners();
  }

  // addItem(Product product) {
  //   if (_items.containsKey(product.id)) {
  //     _items.update(
  //       product.id,
  //       (existingItem) => CartItem(
  //           id: existingItem.id,
  //           productId: product.id,
  //           price: existingItem.price,
  //           quantity: existingItem.quantity + 1,
  //           title: existingItem.title),
  //     );
  //   } else {
  //     _items.putIfAbsent(
  //       product.id,
  //       () => CartItem(
  //         productId: product.id,
  //         id: Random().nextDouble().toString(),
  //         price: product.price,
  //         quantity: 1,
  //         title: product.title,
  //       ),
  //     );
  //   }

  //   notifyListeners();
  // }

  @override
  void dispose() {
    products.close();
    super.dispose();
  }
}
