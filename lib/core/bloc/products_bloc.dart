import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../data/dummy_data.dart';
import '../models/product_model.dart';
import '../utils/extensions.dart';

enum OrderCriteria {
  alphabetic,
  score,
  price,
}

class ProductsBloc extends ChangeNotifier {
  final _productsController =
      BehaviorSubject<List<Product>>.seeded(<Product>[]);

  void Function(List<Product>) get changeProduct =>
      _productsController.sink.add;
  Stream<List<Product>> get productsStream => _productsController.stream;
  List<Product> get productList => _productsController.value;

  void loadProducts() {
    changeProduct(<Product>[]);
    final List<Product> products = productsGame
        .map(
          (product) => Product.fromJson(
            product,
          ),
        )
        .toList();

    changeProduct(products);
  }

  void orderBy(OrderCriteria orderCriteria) {
    switch (orderCriteria) {
      case OrderCriteria.alphabetic:
        orderByAlphabetic();
        break;
      case OrderCriteria.score:
        orderByScore();
        break;
      case OrderCriteria.price:
        orderByPrice();
        break;
    }
  }

  void orderByPrice() {
    List<Product> newList = productList;

    newList.sort((Product a, Product b) => (a.price.toInt() - b.price.toInt()));

    changeProduct(newList);
    notifyListeners();
  }

  void orderByScore() {
    List<Product> newList = productList;
    newList.sort((Product a, Product b) => b.score - a.score);
    changeProduct(newList);
    notifyListeners();
  }

  void orderByAlphabetic() {
    List<Product> newList = productList;
    newList.sort(orderByName);
    changeProduct(newList);
    notifyListeners();
  }

  static int orderByName(Product a, Product b) {
    List<int> aname = a.name.trim().removeAccent().codeUnits;
    List<int> bname = b.name.trim().removeAccent().codeUnits;

    if (a.name.isEmpty) {
      aname = 'u'.codeUnits;
    }
    if (b.name.isEmpty) {
      bname = 'u'.codeUnits;
    }

    int i = 0;
    while (i < bname.length) {
      if (bname[i] < aname[i]) {
        return 1;
      } else if (bname[i] == aname[i]) {
        i++;
        if (i >= aname.length) {
          return 1;
        }
      } else {
        return -1;
      }
    }
    return 1;
  }

  @override
  void dispose() {
    _productsController.close();
    super.dispose();
  }
}
