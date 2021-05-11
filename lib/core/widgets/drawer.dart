import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constantes/strings.dart';
import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AutoSizeText('${SuperShopStrings.welcome} usuário!'),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.shop),
              title: AutoSizeText(SuperShopStrings.shop),
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
              title: AutoSizeText(SuperShopStrings.myOrders),
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
              title: AutoSizeText(SuperShopStrings.cart),
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
              title: AutoSizeText(SuperShopStrings.leaveApp),
              onTap: () {},
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
