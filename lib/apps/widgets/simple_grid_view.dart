import 'package:flutter/widgets.dart';

class const SimpleGridView({
  required final int _columnCount,
  required final int _rowCount,
  required final Widget Function(BuildContext context, int xIndex, int yIndex)
  _cellBuilder,
  super.key,
}) extends StatelessWidget {
  this
    : assert(_columnCount > 0, 'columnCount must be greater than 0'),
      assert(_rowCount > 0, 'rowCount must be greater than 0');

  @override
  Widget build(BuildContext context) => Column(
    children: List.generate(
      _rowCount,
      (yIndex) => Expanded(
        child: Row(
          crossAxisAlignment: .stretch,
          children: List.generate(
            _columnCount,
            (xIndex) => Expanded(child: _cellBuilder(context, xIndex, yIndex)),
          ),
        ),
      ),
    ),
  );
}
