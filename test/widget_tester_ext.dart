import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

extension WidgetTesterEx on WidgetTester {
  Future<void> render(Widget widget) => pumpWidget(
    MaterialApp(
      home: Directionality(textDirection: TextDirection.ltr, child: widget),
    ),
  );
}
