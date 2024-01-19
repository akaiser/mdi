import 'package:flutter/widgets.dart';

class SimpleGridView extends StatelessWidget {
  const SimpleGridView({
    required this.columnCount,
    required this.rowCount,
    required this.cellBuilder,
    super.key,
  })  : assert(columnCount > 0, 'columnCount must be greater than 0'),
        assert(rowCount > 0, 'rowCount must be greater than 0');

  final int columnCount;
  final int rowCount;
  final Widget Function(
    BuildContext context,
    int xIndex,
    int yIndex,
  ) cellBuilder;

  @override
  Widget build(BuildContext context) => Column(
        children: List.generate(
          rowCount,
          (yIndex) => Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                columnCount,
                (xIndex) =>
                    Expanded(child: cellBuilder(context, xIndex, yIndex)),
              ),
            ),
          ),
        ),
      );
}
