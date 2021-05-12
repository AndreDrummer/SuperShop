import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:supers/core/constantes/strings.dart';
import 'package:supers/core/style/text_styles.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AutoSizeText(
        SuperShopStrings.nothingFound,
        style: TextStyles.fontSize26(color: Colors.black87),
      ),
    );
  }
}
