import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/products_bloc.dart';
import 'package:supers/core/models/product_model.dart';
import '../widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: Provider.of<ProductsBloc>(context).productsStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<Product> products = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: EdgeInsets.all(10.0.h),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ProductGridItem(product: products[i]),
          );
        }
        return Center(
          child: AutoSizeText('Nada'),
        );
      },
    );
  }
}
