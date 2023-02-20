import 'package:flutter/widgets.dart';

class SimpleGridView extends StatelessWidget {
  const SimpleGridView({
    required this.columnCount,
    required this.rowCount,
    required this.cellBuilder,
    this.cellPadding,
    this.gridBackgroundColor,
    this.cellBackgroundColor,
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

  final double? cellPadding;
  final Color? gridBackgroundColor;
  final Color? cellBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final _cellPadding = cellPadding;

    final grid = Column(
      children: List.generate(
        rowCount,
        (yIndex) => Expanded(
          child: Row(
            children: List.generate(
              columnCount,
              (xIndex) {
                final cell = SizedBox.expand(
                  child: cellBuilder(
                    context,
                    xIndex,
                    yIndex,
                  ),
                );

                final _cellBackgroundColor = cellBackgroundColor;
                final coloredCell = _cellBackgroundColor != null
                    ? ColoredBox(
                        color: _cellBackgroundColor,
                        child: cell,
                      )
                    : cell;

                return Expanded(
                  child: _cellPadding != null
                      ? Padding(
                          padding: EdgeInsets.all(_cellPadding),
                          child: coloredCell,
                        )
                      : coloredCell,
                );
              },
            ),
          ),
        ),
      ),
    );
    final paddedGrid = _cellPadding != null
        ? Padding(
            padding: EdgeInsets.all(_cellPadding),
            child: grid,
          )
        : grid;

    final _gridBackgroundColor = gridBackgroundColor;
    return _gridBackgroundColor != null
        ? ColoredBox(
            color: _gridBackgroundColor,
            child: paddedGrid,
          )
        : paddedGrid;
  }
}
