import 'package:flutter/cupertino.dart';

extension StringExt on String {
  Widget text(
      {double fontSize = 14,
        Color? color,
        TextAlign? textAlign,
        FontWeight? fontWeight}) =>
      Text(
        this,
        textAlign: textAlign,
        style:
        TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
      );

  Widget boldText({
    double fontSize = 14,
    Color? color,
  }) =>
      Text(
        this,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
      );
}