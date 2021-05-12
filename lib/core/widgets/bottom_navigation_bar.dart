import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constantes/sizes.dart';
import '../style/text_styles.dart';

class BottomBar extends StatelessWidget {
  BottomBar({
    this.centerTitle = false,
    required this.title,
    this.bottomSize,
    this.actionText,
    this.action,
  });

  final String? actionText;
  final double? bottomSize;
  final Function? action;
  final bool centerTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.h),
      color: Theme.of(context).accentColor,
      height: bottomSize ?? 65.0.h,
      width: Sizes.deviceWidth(context),
      child: Row(
        mainAxisAlignment: centerTitle
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: centerTitle ? Sizes.deviceWidth(context) * 0.2 : 0.0.h),
            child: AutoSizeText(
              title,
              style: TextStyles.fontSize26(),
            ),
          ),
          TextButton(
            onPressed: () {
              action?.call();
            },
            child: AutoSizeText(
              actionText ?? '',
              style: TextStyles.fontSize18(),
            ),
          ),
        ],
      ),
    );
  }
}
