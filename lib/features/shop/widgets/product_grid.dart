import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/products_bloc.dart';

import '../widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final showOnlyFavorite;

  ProductGrid({this.showOnlyFavorite = false});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsBloc>(context);
    final products = productsProvider.productList;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductGridItem(product: products[i])
        // itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //   value: products[i],
        //   child: ProductGridItem(),
        // ),
        );
  }
}
