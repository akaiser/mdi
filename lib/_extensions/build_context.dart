import 'package:flutter/material.dart';
import 'package:mdi/_shared/theme.dart';

extension BuildContextEx on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppTextTheme get appTextTheme => AppTextTheme.of(textTheme);
}
