import 'package:flutter/widgets.dart';

class DesktopApp {
  const DesktopApp(
    this.title,
    this.icon,
    this.app, {
    this.width,
    this.height,
    this.isFixedSize = false,
  });

  final String title;
  final IconData icon;
  final Widget app;

  final double? width;
  final double? height;
  final bool isFixedSize;
}
