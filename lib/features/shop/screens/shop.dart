import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/svg_path.dart';

import '../../../core/bloc/cart_bloc.dart';
import '../../../core/bloc/products_bloc.dart';
import '../../../core/constantes/strings.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/badge.dart';
import '../../../core/widgets/bottom_navigation_bar.dart';
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
              child: Padding(
                padding: EdgeInsets.all(12.0.w),
                child: InkWell(
                  child: SvgPicture.asset(
                    SVGPath.cartIcon,
                    color: Colors.white,
                    height: 25,
                    semanticsLabel: 'A red up arrow',
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.CART,
                    );
                  },
                ),
              ),
              builder: (_, cart, child) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.CART,
                  );
                },
                child: Badge(
                  value: '${cart.cartList.length}',
                  child: child!,
                ),
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
                  child: BottomBar(
                    title:
                        '${SuperShopStrings.cartTotalPrice} ${formatCurrency.format(cart.cartPrice)}',
                    action: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.CART,
                      );
                    },
                    actionText: '${SuperShopStrings.seeCart}',
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
