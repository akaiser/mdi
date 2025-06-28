import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class DesktopApp extends Equatable {
  const DesktopApp(
    this.title,
    this.icon,
    this.app, {
    this.width,
    this.height,
    this.isFolder = false,
    this.isFixedSize = false,
  });

  final String title;
  final IconData icon;
  final Widget app;

  final double? width;
  final double? height;
  final bool isFolder;
  final bool isFixedSize;

  @override
  List<Object?> get props => [
    title,
    icon,
    app,
    width,
    height,
    isFolder,
    isFixedSize,
  ];
}
