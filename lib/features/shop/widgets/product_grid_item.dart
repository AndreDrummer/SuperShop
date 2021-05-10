import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/products_bloc.dart';

import '../../../core/models/product_model.dart';
import '../../../core/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  ProductGridItem({
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCTS_DETAIL,
              arguments: product,
            );
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/placeholder.png'),
              image: AssetImage(
                'assets/${product.image}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<ProductsBloc>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(Icons.favorite),
              color: Theme.of(context).accentColor,
              onPressed: () {},
            ),
          ),
          title: Text(product.name),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text('Item adicionado com sucesso!'),
                action: SnackBarAction(
                  label: 'DESFAZER',
                  onPressed: () {},
                ),
              ));
              // cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
