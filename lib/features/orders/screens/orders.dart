import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:supers/core/bloc/order_bloc.dart';
import 'package:supers/core/constantes/strings.dart';
import 'package:supers/core/models/order_model.dart';
import 'package:supers/core/widgets/drawer.dart';
import 'package:supers/core/widgets/empty_screen.dart';
import 'package:supers/features/orders/widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(SuperShopStrings.myOrders),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<List<Order>>(
        stream: Provider.of<OrderBloc>(context).ordersStream,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return EmptyScreen();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, i) {
              return OrderItemWidget(
                snapshot.data![i],
              );
            },
          );
        },
      ),
    );
  }
}
