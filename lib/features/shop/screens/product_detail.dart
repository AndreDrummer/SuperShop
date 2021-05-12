import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/cart_bloc.dart';
import 'package:supers/core/constantes/strings.dart';
import 'package:supers/core/mixins/notification.dart';
import 'package:supers/core/models/product_model.dart';
import 'package:supers/core/style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/utils/currency_formatter.dart';

class ProductDetailScreen extends StatelessWidget with NotificationMixin {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      bottomNavigationBar: Consumer<CartBloc>(
        builder: (ctx, cart, _) => Container(
          height: 50.0.h,
          child: ElevatedButton(
            onPressed: () {
              cart.addItem(product);
              showNotification(
                SuperShopStrings.itemAddedToTheCart,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
            ),
            child: AutoSizeText(
              cart.elementUserExistsOnList(product)
                  ? SuperShopStrings.productOnCart
                  : SuperShopStrings.addToTheCart,
              style: TextStyles.fontSize26(),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0.h,
            pinned: true,
            leading: BackButton(
              color: Colors.black87,
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: AutoSizeText(product.name),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: product.id,
                    child: Image.asset(
                      'assets/${product.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.8),
                        end: Alignment(0.0, 0.0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Row(
                    children: [
                      AutoSizeText(
                        SuperShopStrings.score,
                        style: TextStyles.fontSize26(color: Colors.black87),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Row(
                          children: List.generate(
                            product.score < 100 ? 1 : product.score ~/ 100,
                            (index) => Icon(
                              Icons.star,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      AutoSizeText(
                        '${formatCurrency.format(product.price)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10000.0.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
