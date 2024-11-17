import 'package:flutter/cupertino.dart';

extension IntExt on int {
  Widget get height => SizedBox(
    height: toDouble(),
  );
  Widget get width => SizedBox(
    width: toDouble(),
  );
}