import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterEx on WidgetTester {
  Future<void> render(Widget widget) => pumpWidget(
    MaterialApp(
      home: Directionality(textDirection: TextDirection.ltr, child: widget),
    ),
  );
}
