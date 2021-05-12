import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supers/core/bloc/cart_bloc.dart';
import 'package:supers/core/style/text_styles.dart';

class CartQtyControlls extends StatelessWidget {
  CartQtyControlls({
    required this.remove,
    required this.add,
    required this.qty,
  });

  final Function remove;
  final Function add;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartBloc>(
      builder: (ctx, cart, _) => Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AutoSizeText(
              '$qty x',
              style: TextStyles.fontSize18(color: Colors.black87),
            ),
            InkWell(
              onTap: () => add(),
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 14.0.h),
              child: InkWell(
                child: Icon(Icons.minimize, color: Colors.black, size: 22),
                onTap: () => remove(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
