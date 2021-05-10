import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartBloc extends ChangeNotifier {
  final _itemsCart = BehaviorSubject<BuiltList<Cart>>.seeded(BuiltList<Cart>());

  void Function(BuiltList<Cart>) get changeCart => _itemsCart.sink.add;
  Stream<BuiltList<Cart>> get cartStream => _itemsCart.stream;
  BuiltList<Cart> get cartList => _itemsCart.value;

  void loadCart() {
    changeCart(BuiltList<Cart>());
    BuiltList<Cart> cartList = BuiltList<Cart>();
  }

  addItem(Product product) {
    notifyListeners();
  }

  @override
  void dispose() {
    _itemsCart.close();
    super.dispose();
  }
}
