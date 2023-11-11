import 'package:flutter/widgets.dart';
import 'package:mdi/apps/auto_count.dart';
import 'package:mdi/apps/widgets/simple_split_view.dart';

class SomeSplitView extends SimpleSplitView {
  const SomeSplitView()
      : super(
          left: const ColoredBox(
            color: Color.fromRGBO(0, 0, 0, 1),
            child: Center(
              child: Text(
                'Left',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ),
          right: const AutoCount(),
        );
}
