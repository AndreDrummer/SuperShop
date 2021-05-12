import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/mixins/notification.dart';
import 'package:supers/core/style/text_styles.dart';
import 'package:supers/core/utils/app_routes.dart';
import 'package:supers/core/widgets/bottom_navigation_bar.dart';
import '../../../core/bloc/cart_bloc.dart';
import '../../../core/bloc/order_bloc.dart';
import '../../../core/constantes/strings.dart';
import '../../../core/models/order_model.dart';
import '../../../core/utils/currency_formatter.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with NotificationMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartBloc>(
      builder: (ctx, cart, _) => Scaffold(
        appBar: AppBar(
          title: Text(SuperShopStrings.cart),
        ),
        bottomNavigationBar: Consumer<OrderBloc>(
          builder: (ctx, order, _) => GestureDetector(
            onTap: () {
              cart.clearCart();
              showNotification(SuperShopStrings.purchaseSuccess, seconds: 3);
              Provider.of<OrderBloc>(context, listen: false).purchase(
                Order(
                  date: DateTime.now(),
                  id: order.ordersValue.length + 1,
                  items: cart.cartList,
                  total: cart.checkoutValue,
                ),
              );
              Navigator.pushNamed(
                context,
                AppRoutes.ORDERS,
              );
            },
            child: BottomBar(
              centerTitle: true,
              title: SuperShopStrings.buy.toUpperCase(),
              bottomSize: 50,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartList.length,
                itemBuilder: (ctx, i) => CartItemWidegt(
                  cartItem: cart.cartList[i],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(25),
              child: Padding(
                padding: EdgeInsets.all(4.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      SuperShopStrings.cartTotalPrice,
                      style: TextStyles.fontSize26(
                        color: Colors.black87,
                      ),
                    ),
                    Spacer(),
                    Chip(
                      backgroundColor: Theme.of(context).accentColor,
                      label: Text(
                        '${formatCurrency.format(cart.checkoutValue)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
