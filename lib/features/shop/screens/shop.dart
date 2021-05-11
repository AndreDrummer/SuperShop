import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bloc/cart_bloc.dart';
import '../../../core/bloc/products_bloc.dart';
import '../../../core/constantes/strings.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/widgets/badge.dart';
import '../../../core/widgets/drawer.dart';
import '../widgets/product_grid.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late ProductsBloc productsBloc;

  @override
  void initState() {
    productsBloc = Provider.of<ProductsBloc>(context, listen: false);
    productsBloc.loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(SuperShopStrings.appTitle),
          actions: [
            PopupMenuButton<OrderCriteria>(
              icon: Icon(Icons.settings_input_composite_rounded),
              onSelected: (value) {
                print('$value');
                productsBloc.orderBy(value);
              },
              itemBuilder: (context) {
                return <PopupMenuEntry<OrderCriteria>>[
                  PopupMenuItem(
                    child: Text(SuperShopStrings.orderByPrice),
                    value: OrderCriteria.price,
                  ),
                  PopupMenuItem(
                    child: Text(SuperShopStrings.orderByName),
                    value: OrderCriteria.alphabetic,
                  ),
                  PopupMenuItem(
                    child: Text(SuperShopStrings.orderByScore),
                    value: OrderCriteria.score,
                  ),
                ];
              },
            ),
            Consumer<CartBloc>(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.CART,
                  );
                },
              ),
              builder: (_, cart, child) => Badge(
                value: '0',
                child: child!,
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: ProductGrid(),
      ),
    );
  }

  void showSettingsPopUp() {}
}
