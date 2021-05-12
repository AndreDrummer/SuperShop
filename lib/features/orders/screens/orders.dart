import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:supers/core/bloc/order_bloc.dart';
import 'package:supers/core/constantes/strings.dart';
import 'package:supers/core/widgets/drawer.dart';
import 'package:supers/core/widgets/empty_screen.dart';
import 'package:supers/features/orders/widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SuperShopStrings.myOrders),
      ),
      drawer: AppDrawer(),
      body: Consumer<OrderBloc>(
        builder: (context, orders, child) {
          if (orders.ordersValue.isEmpty) return EmptyScreen();
          return ListView.builder(
            itemCount: orders.ordersValue.length,
            itemBuilder: (_, i) => OrderItemWidget(
              orders.ordersValue[i],
            ),
          );
        },
      ),
    );
  }
}
