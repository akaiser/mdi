import 'package:flutter/material.dart';

extension BuildContextEx on BuildContext {
  TextTheme get tt => Theme.of(this).textTheme;
}
