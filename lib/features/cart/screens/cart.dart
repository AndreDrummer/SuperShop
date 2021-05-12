import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/mixins/notification.dart';
import 'package:supers/core/style/text_styles.dart';
import 'package:supers/core/utils/app_routes.dart';
import 'package:supers/core/widgets/bottom_navigation_bar.dart';
import 'package:supers/core/widgets/shopping_value.dart';
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
          title: AutoSizeText(SuperShopStrings.cart),
        ),
        bottomNavigationBar: Consumer<OrderBloc>(
          builder: (ctx, order, _) => GestureDetector(
            onTap: cart.cartList.isEmpty
                ? null
                : () {
                    var purchase = Order(
                      shippingValue: cart.shippingValue,
                      id: order.ordersValue.length + 1,
                      total: cart.checkoutValue,
                      date: DateTime.now(),
                      items: cart.cartList,
                    );

                    Provider.of<OrderBloc>(context, listen: false)
                        .purchase(purchase);
                    cart.clearCart();
                    showNotification(
                      SuperShopStrings.purchaseSuccess,
                      seconds: 3,
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                  child: ShoppingValue(
                    shoppingValue: cart.shippingValue,
                  ),
                ),
                Card(
                  elevation: 8.0.h,
                  margin: EdgeInsets.all(25.0.h),
                  child: Padding(
                    padding: EdgeInsets.all(4.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          SuperShopStrings.cartTotalPrice,
                          style: TextStyles.fontSize26(
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Chip(
                          backgroundColor: Theme.of(context).accentColor,
                          label: AutoSizeText(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
