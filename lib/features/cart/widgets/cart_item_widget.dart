import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/bloc/cart_bloc.dart';
import '../../../core/constantes/strings.dart';
import '../../../core/mixins/notification.dart';
import '../../../core/models/cart_model.dart';
import 'cartQtyControlls.dart';

class CartItemWidegt extends StatelessWidget with NotificationMixin {
  final CartItem cartItem;

  CartItemWidegt({
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        Provider.of<CartBloc>(context, listen: false).removeItem(
          cartItem.product,
        );
        showNotification(
          SuperShopStrings.itemRemovedFromTheCart,
        );
      },
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: AutoSizeText(SuperShopStrings.sure),
            content: AutoSizeText(SuperShopStrings.wannaRemoveItem),
            actions: <Widget>[
              TextButton(
                child: AutoSizeText(SuperShopStrings.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: AutoSizeText(SuperShopStrings.yes),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(cartItem.product.id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0.w,
          vertical: 4.0.h,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 8.0.h,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 4.0.h,
          ),
          child: ListTile(
            leading: Hero(
              tag: cartItem.product.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/placeholder.png'),
                image: AssetImage(
                  'assets/${cartItem.product.image}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            title: AutoSizeText('${cartItem.product.name}'),
            subtitle: AutoSizeText(
                '${SuperShopStrings.cartTotalPrice}: ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Consumer<CartBloc>(
              builder: (ctx, cart, _) => CartQtyControlls(
                qty: cartItem.quantity,
                add: () => cart.incrementProductQty(cartItem.product.id),
                remove: () => cart.decrementProductQty(cartItem.product.id),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
