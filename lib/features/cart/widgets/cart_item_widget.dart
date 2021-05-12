import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/cart_bloc.dart';
import 'package:supers/core/constantes/strings.dart';
import 'package:supers/core/models/cart_model.dart';

class CartItemWidegt extends StatelessWidget {
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
      },
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(SuperShopStrings.sure),
            content: Text(SuperShopStrings.wannaRemoveItem),
            actions: <Widget>[
              TextButton(
                child: Text(SuperShopStrings.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(SuperShopStrings.yes),
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
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
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
            title: Text('${cartItem.product.name}'),
            subtitle: Text(
                '${SuperShopStrings.cartTotalPrice}: ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
