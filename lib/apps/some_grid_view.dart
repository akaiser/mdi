import 'package:flutter/material.dart';
import 'package:mdi/apps/widgets/simple_grid_view.dart';

const _cellPadding = 4.0;

class const SomeGridView({super.key}) extends StatefulWidget {
  @override
  State<SomeGridView> createState() => _SomeGridViewState();
}

class _SomeGridViewState extends State<SomeGridView> {
  var _columnCount = 2;
  var _rowCount = 2;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const .only(
          left: _cellPadding * 2,
          top: _cellPadding * 2,
          right: _cellPadding * 2,
        ),
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_columnCount > 1) {
                        setState(() => _columnCount--);
                      }
                    },
                    child: const Text('-'),
                  ),
                  Text('$_columnCount Columns'),
                  TextButton(
                    onPressed: () => setState(() => _columnCount++),
                    child: const Text('+'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_rowCount > 1) {
                        setState(() => _rowCount--);
                      }
                    },
                    child: const Text('-'),
                  ),
                  Text('$_rowCount Rows'),
                  TextButton(
                    onPressed: () => setState(() => _rowCount++),
                    child: const Text('+'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const .all(_cellPadding),
          child: SimpleGridView(
            columnCount: _columnCount,
            rowCount: _rowCount,
            cellBuilder: (context, xIndex, yIndex) => Container(
              margin: const .all(_cellPadding),
              alignment: .center,
              color: Colors.blueAccent,
              child: Text('$xIndex:$yIndex'),
            ),
          ),
        ),
      ),
    ],
  );
}
