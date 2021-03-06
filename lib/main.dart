import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:supers/features/cart/screens/cart.dart';
import 'package:supers/features/orders/screens/orders.dart';

import 'core/constantes/custom_colors.dart';
import 'core/providers.dart';
import 'core/utils/app_routes.dart';
import 'features/shop/screens/product_detail.dart';
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
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => OverlaySupport(
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: CustomColors.hexPrimary,
              accentColor: CustomColors.hexAccent,
              fontFamily: 'Lato',
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              AppRoutes.PRODUCTS_DETAIL: (ctx) => ProductDetailScreen(),
              AppRoutes.ORDERS: (ctx) => OrdersScreen(),
              AppRoutes.SHOP: (ctx) => ShopScreen(),
              AppRoutes.CART: (ctx) => CartScreen(),
            },
          ),
        ),
      ),
    );
  }
}
