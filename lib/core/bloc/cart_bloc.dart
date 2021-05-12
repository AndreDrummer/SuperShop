import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartBloc extends ChangeNotifier {
  final _shippingValueControler = BehaviorSubject<double>.seeded(0.0);
  final _itemsCartControler =
      BehaviorSubject<List<CartItem>>.seeded(<CartItem>[]);
  final _cartPriceControler = BehaviorSubject<double>.seeded(0.0);

  Stream<double> get shippingValueStream => _shippingValueControler.stream;
  void Function(double) get changeShippingValue =>
      _shippingValueControler.sink.add;
  double get shippingValue => _shippingValueControler.value;

  void Function(double) get changeCartPrice => _cartPriceControler.sink.add;
  Stream<double> get cartPriceStream => _cartPriceControler.stream;
  double get cartPrice => _cartPriceControler.value;

  void Function(List<CartItem>) get changeCart => _itemsCartControler.sink.add;
  Stream<List<CartItem>> get cartStream => _itemsCartControler.stream;
  List<CartItem> get cartList => _itemsCartControler.value;

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
          price: product.price,
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
      newPrice: (productOnCart.quantity + 1) * productOnCart.price,
      newQuantity: productOnCart.quantity + 1,
    );
    changeCart(currentCart);
    calculateCheckoutValue();
    notifyListeners();
  }

  void decrementProductQty(int productId) {
    List<CartItem> currentCart = cartList;
    var productIndex = currentCart.indexOf(
      currentCart.where((cartItem) => cartItem.product.id == productId).first,
    );
    CartItem productOnCart = currentCart.elementAt(productIndex);
    if (productOnCart.quantity == 1) {
      removeItem(productOnCart.product);
    } else {
      currentCart[productIndex] = productOnCart.copyWith(
        newPrice: (productOnCart.quantity - 1) * productOnCart.price,
        newQuantity: productOnCart.quantity - 1,
      );
    }
    changeCart(currentCart);
    calculateCheckoutValue();
    notifyListeners();
  }

  void calculateCheckoutValue() {
    var productsValue = cartList
        .map((e) => e.product.price * e.quantity)
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
    _shippingValueControler.close();
    _itemsCartControler.close();
    _cartPriceControler.close();
    super.dispose();
  }
}
