import 'package:flutter/material.dart';

import '../style/text_styles.dart';

class OverlayNotification extends StatelessWidget {
  OverlayNotification({
    required this.backgroundColor,
    required this.description,
    required this.title,
  });

  final Color backgroundColor;
  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * (.03),
          vertical: 4,
        ),
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          title: Text(
            title,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Text(
            description,
            maxLines: 3,
            style: TextStyles.fontSize18(),
          ),
        ),
      ),
    );
  }
}
