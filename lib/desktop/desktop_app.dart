import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class const DesktopApp(
  final String title,
  final IconData icon,
  final Widget app, {
  final double? width,
  final double? height,
  final bool isFolder = false,
  final bool isFixedSize = false,
}) extends Equatable {
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
