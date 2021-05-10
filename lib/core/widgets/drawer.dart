import 'package:flutter/material.dart';
import 'package:supers/core/constantes/strings.dart';

import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${SuperShopStrings.welcome} usuário!'),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.shop),
              title: Text(SuperShopStrings.shop),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.SHOP,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text(SuperShopStrings.myOrders),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.ORDERS,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(SuperShopStrings.cart),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.PRODUCTS,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(SuperShopStrings.leaveApp),
              onTap: () {},
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
