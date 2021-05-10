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
  void didChangeDependencies() {
    productsBloc = Provider.of<ProductsBloc>(context);
    productsBloc.loadProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(SuperShopStrings.appTitle),
          actions: [
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
}
