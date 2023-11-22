import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  TextTheme get tt => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.sizeOf(this);
}
