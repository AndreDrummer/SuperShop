import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:supers/core/constantes/strings.dart';
import 'package:supers/core/utils/currency_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShoppingValue extends StatelessWidget {
  ShoppingValue({
    required this.shoppingValue,
  });
  final double shoppingValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AutoSizeText(
          SuperShopStrings.shoppingValue,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        AutoSizeText(
          '${formatCurrency.format(shoppingValue)}',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
