import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/mixins/notification.dart';
import 'package:supers/core/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/cart_bloc.dart';
import 'package:supers/core/constantes/strings.dart';

import '../../../core/constantes/sizes.dart';
import '../../../core/models/product_model.dart';
import '../../../core/style/text_styles.dart';
import '../../../core/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget with NotificationMixin {
  ProductGridItem({
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: Sizes.deviceHeight(context) / 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCTS_DETAIL,
              arguments: product,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
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
        ),
        footer: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0.h),
              AutoSizeText(
                product.name,
                style: TextStyles.fontSize14(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    '${formatCurrency.format(product.price)}',
                    style: TextStyles.fontSize18(),
                  ),
                  Consumer<CartBloc>(
                    builder: (_, cart, child) {
                      return IconButton(
                        icon: _wichShoppingCartIcon(context, product),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (cart.elementUserExistsOnList(product)) {
                            cart.removeItem(product);
                            showNotification(
                              SuperShopStrings.itemRemovedFromTheCart,
                            );
                          } else {
                            cart.addItem(product);
                            showNotification(
                              SuperShopStrings.itemAddedToTheCart,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Icon _wichShoppingCartIcon(BuildContext context, Product product) {
    if (Provider.of<CartBloc>(context).elementUserExistsOnList(product))
      return Icon(Icons.shopping_cart);
    return Icon(Icons.shopping_cart_outlined);
  }
}
