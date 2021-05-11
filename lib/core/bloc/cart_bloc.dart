import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:supers/core/models/product_model.dart';

import '../data/dummy_data.dart';
import '../models/cart_model.dart';

class CartBloc extends ChangeNotifier {
  final _itemsCart = BehaviorSubject<List<CartItem>>.seeded(<CartItem>[]);

  void Function(List<CartItem>) get changeCart => _itemsCart.sink.add;
  Stream<List<CartItem>> get cartStream => _itemsCart.stream;
  List<CartItem> get cartList => _itemsCart.value;

  void loadCart() {
    changeCart(<CartItem>[]);
    final List<CartItem> carts = cart
        .map(
          (cart) => CartItem.fromJson(
            cart,
          ),
        )
        .toList();

    changeCart(carts);
  }

  void addItem(Product product) {
    List<CartItem> currentCart = cartList;
    if (elementUserExistsOnList(product)) {
      var productIndex = currentCart.indexOf(
        currentCart
            .where((cartItem) => cartItem.product.id == product.id)
            .first,
      );
      CartItem productOnCart = currentCart.elementAt(productIndex);
      currentCart[productIndex] = productOnCart.copyWith(
        newQuantity: productOnCart.quantity + 1,
      );
      changeCart(currentCart);
    } else {
      currentCart.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
      changeCart(currentCart);
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    List<CartItem> currentCart = cartList;
    if (elementUserExistsOnList(product)) {
      var productIndex = currentCart.indexOf(
        currentCart
            .where((cartItem) => cartItem.product.id == product.id)
            .first,
      );
      currentCart.removeAt(productIndex);
      changeCart(currentCart);
    }
    notifyListeners();
  }

  bool elementUserExistsOnList(Product product) {
    var result = false;
    cartList.forEach((element) {
      if (element.product.id == product.id) result = true;
    });
    return result;
  }

  @override
  void dispose() {
    _itemsCart.close();
    super.dispose();
  }
}
