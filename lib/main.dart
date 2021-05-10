import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers.dart';
import 'core/utils/app_routes.dart';
import 'features/shop/screens/shop.dart';

void main() {
  runApp(SuperShop());
}

class SuperShop extends StatefulWidget {
  @override
  _SuperShopState createState() => _SuperShopState();
}

class _SuperShopState extends State<SuperShop> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.SHOP: (ctx) => ShopScreen(),
        },
      ),
    );
  }
}

class ProductFormScreen {}
