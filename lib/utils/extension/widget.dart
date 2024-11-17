import 'package:flutter/cupertino.dart';

extension WidgetExt on Widget {
  Widget expanded({int flex = 1}) => Expanded(
    flex: flex,
    child: this,
  );
  Widget flexible() => Flexible(child: this);
  Widget center() => Align(
    alignment: Alignment.center,
    child: this,
  );
}