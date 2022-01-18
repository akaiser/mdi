import 'package:flutter/material.dart';
import 'package:mdi/_shared/theme.dart';

extension BuildContextEx on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  Size get screenSize => mediaQueryData.size;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppTextTheme get appTextTheme => AppTextTheme.of(textTheme);
}
