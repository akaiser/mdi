import 'package:flutter/widgets.dart';
import 'package:mdi/apps/auto_count.dart';
import 'package:mdi/apps/widgets/simple_split_view.dart';

class const SomeSplitView({super.key}) extends SimpleSplitView {
  this
    : super(
        left: const ColoredBox(
          color: .fromRGBO(0, 0, 0, 1),
          child: Center(
            child: Text(
              'Left',
              style: TextStyle(color: .fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
        right: const AutoCount(),
      );
}
