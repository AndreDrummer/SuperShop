import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../models/order_model.dart';

class OrderBloc extends ChangeNotifier {
  final _ordersController = BehaviorSubject<List<Order>>.seeded(<Order>[]);

  void Function(List<Order>) get changeOrders => _ordersController.sink.add;
  Stream<List<Order>> get ordersStream => _ordersController.stream;
  List<Order> get ordersValue => _ordersController.value;

  void purchase(Order order) {
    List<Order> currentOrders = ordersValue;

    currentOrders.add(
      Order(
        shippingValue: order.shippingValue,
        id: currentOrders.length + 1,
        items: order.items,
        total: order.total,
        date: order.date,
      ),
    );
    changeOrders(currentOrders);

    notifyListeners();
  }

  bool elementUserExistsOnList(Order order) {
    var result = false;
    ordersValue.forEach((element) {
      if (element.id == order.id) result = true;
    });
    return result;
  }

  @override
  void dispose() {
    _ordersController.close();
    super.dispose();
  }
}
