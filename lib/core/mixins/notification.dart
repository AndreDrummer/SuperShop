import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supers/core/utils/overlat_notification.dart';

mixin NotificationMixin {
  void showNotification(String message,
      {String errorTitle = 'Sucesso!', int? seconds}) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        showOverlayNotification(
          (context) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 3.0.h),
              child: OverlayNotification(
                title: errorTitle,
                description: message,
                backgroundColor: Theme.of(context).accentColor,
              ),
            );
          },
          position: NotificationPosition.top,
          duration: Duration(seconds: seconds ?? 1),
        );
      },
    );
  }
}
