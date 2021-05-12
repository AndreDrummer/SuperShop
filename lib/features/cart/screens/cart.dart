import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SuperShopStrings.cart),
      ),
      body: Consumer<CartBloc>(
        builder: (ctx, cart, _) => Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(25),
              child: Padding(
                padding: EdgeInsets.all(4.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      SuperShopStrings.cartTotalPrice,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Chip(
                      backgroundColor: Theme.of(context).accentColor,
                      label: Text(
                        '${formatCurrency.format(cart.checkoutValue)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Consumer<OrderBloc>(
                      builder: (ctx, order, _) => OrderButton(
                        order: Order(
                          date: DateTime.now(),
                          id: order.ordersValue.length + 1,
                          items: cart.cartList,
                          total: cart.checkoutValue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartList.length,
                itemBuilder: (ctx, i) => CartItemWidegt(
                  cartItem: cart.cartList[i],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  late CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : cartBloc.cartList.isEmpty
            ? Container()
            : TextButton(
                child: Text(
                  SuperShopStrings.buy,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: widget.order.total == 0
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });

                        Provider.of<OrderBloc>(context, listen: false)
                            .purchase(widget.order);

                        setState(() {
                          _isLoading = false;
                        });
                      },
              );
  }
}
