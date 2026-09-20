import 'package:material_ui/material_ui.dart';

extension BuildContextExt on BuildContext {
  TextTheme get tt => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.sizeOf(this);
}
