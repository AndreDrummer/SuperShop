import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supers/core/models/order_model.dart';
import 'package:supers/core/utils/currency_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/widgets/shopping_value.dart';

class OrderItemWidget extends StatefulWidget {
  final Order order;
  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final itemsHeight = (widget.order.items.length * 25.0) + 10;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: _isExpanded ? itemsHeight + 95 : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title:
                  AutoSizeText('${formatCurrency.format(widget.order.total)}'),
              subtitle: AutoSizeText(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
              ),
              trailing: IconButton(
                icon: Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: _isExpanded ? itemsHeight : 0,
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: ListView.builder(
                itemCount: widget.order.items.length + 1,
                itemBuilder: (ctx, index) {
                  if (index == widget.order.items.length) {
                    return ShoppingValue(
                      shoppingValue: widget.order.shippingValue,
                    );
                  }

                  var item = widget.order.items[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText(
                        item.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      AutoSizeText(
                        '${item.quantity}x ${formatCurrency.format(item.product.price)}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
