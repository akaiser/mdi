import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme(this._textTheme);

  factory AppTextTheme.of(TextTheme textTheme) => AppTextTheme(textTheme);

  final TextTheme _textTheme;

  TextStyle get h1 => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h2 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h3 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h4 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h5 => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      );

  TextStyle get h6 => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      );

  TextStyle get paragraph => _textTheme.headline6!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get medium => _textTheme.headline6!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  TextStyle get small => _textTheme.headline6!.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      );
}
