import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartBloc extends ChangeNotifier {
  final _itemsCart = BehaviorSubject<List<CartItem>>.seeded(<CartItem>[]);
  final _shippingValue = BehaviorSubject<double>.seeded(0.0);
  final _cartPrice = BehaviorSubject<double>.seeded(0.0);

  void Function(double) get changeShippingValue => _shippingValue.sink.add;
  Stream<double> get shippingValueStream => _shippingValue.stream;
  double get shippingValue => _shippingValue.value;

  void Function(double) get changeCartPrice => _cartPrice.sink.add;
  Stream<double> get cartPriceStream => _cartPrice.stream;
  double get cartPrice => _cartPrice.value;

  void Function(List<CartItem>) get changeCart => _itemsCart.sink.add;
  Stream<List<CartItem>> get cartStream => _itemsCart.stream;
  List<CartItem> get cartList => _itemsCart.value;

  double get checkoutValue => cartPrice + shippingValue;

  void clearCart() {
    changeCart(<CartItem>[]);
    calculateCheckoutValue();
    notifyListeners();
  }

  void addItem(Product product) {
    List<CartItem> currentCart = cartList;
    if (elementUserExistsOnList(product)) {
      removeItem(product);
    } else {
      currentCart.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
      changeCart(currentCart);
      calculateCheckoutValue();
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
      calculateCheckoutValue();
    }
    notifyListeners();
  }

  void incrementProductQty(int productId) {
    List<CartItem> currentCart = cartList;
    var productIndex = currentCart.indexOf(
      currentCart.where((cartItem) => cartItem.product.id == productId).first,
    );
    CartItem productOnCart = currentCart.elementAt(productIndex);
    currentCart[productIndex] = productOnCart.copyWith(
      newQuantity: productOnCart.quantity + 1,
    );
    changeCart(currentCart);
    calculateCheckoutValue();
  }

  void calculateCheckoutValue() {
    var productsValue = cartList
        .map((e) => e.product.price)
        .fold(0, (prev, element) => double.parse(prev!.toString()) + element)
        .toDouble();
    changeCartPrice(productsValue);
    var shippingValue = productsValue >= 250 ? 0.0 : cartList.length * 10.0;
    changeShippingValue(shippingValue);
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
    _shippingValue.close();
    _itemsCart.close();
    _cartPrice.close();
    super.dispose();
  }
}
