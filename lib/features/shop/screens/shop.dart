import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/constantes/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/style/text_styles.dart';
import 'package:supers/core/utils/currency_formatter.dart';
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
                value: '${cart.cartList.length}',
                child: child!,
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: Consumer<CartBloc>(
          builder: (_, cart, child) => Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: cart.cartList.isNotEmpty ? 48.0.h : 0.0,
                ),
                child: ProductGrid(),
              ),
              if (cart.cartList.isNotEmpty)
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0.h),
                    color: Colors.red,
                    height: 50,
                    width: Sizes.deviceWidth(context),
                    child: AutoSizeText(
                      'Checkout: ${formatCurrency.format(cart.checkoutValue)}',
                      style: TextStyles.fontSize26(),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
