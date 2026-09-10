import 'package:flutter/material.dart';
import 'package:mdi/apps/widgets/simple_grid_view.dart';

const _columnCount = 3;
const _rowCount = 3;
const int _boardSize = _columnCount * _rowCount;
const _cellPadding = 4.0;

const _winSections = [
  // diagonal
  ['0:0', '1:1', '2:2'],
  ['0:2', '1:1', '2:0'],
  // horizontal
  ['0:0', '1:0', '2:0'],
  ['0:1', '1:1', '2:1'],
  ['0:2', '1:2', '2:2'],
  // vertical
  ['0:0', '0:1', '0:2'],
  ['1:0', '1:1', '1:2'],
  ['2:0', '2:1', '2:2'],
];

enum _Type { X, O }

const _dialogDelay = Duration(milliseconds: 300);

class const TikTakToe({super.key}) extends StatefulWidget {
  @override
  State<TikTakToe> createState() => _TikTakToeState();
}

class _TikTakToeState extends State<TikTakToe> {
  final _selection = <String, _Type>{};
  var _isCrossTurn = true;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(_cellPadding),
    child: SimpleGridView(
      columnCount: _columnCount,
      rowCount: _rowCount,
      cellBuilder: (context, xIndex, yIndex) {
        final current = '$xIndex:$yIndex';
        final existing = _selection[current];

        return _Cell(
          child: existing != null
              ? FittedBox(
                  child: Icon(
                    existing == _Type.X
                        ? Icons.close
                        : Icons.radio_button_unchecked,
                    color: Colors.white,
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    _selection[current] = _isCrossTurn ? _Type.X : _Type.O;
                    _isCrossTurn = !_isCrossTurn;
                    setState(() {});
                    await _lookupWinner();
                  },
                ),
        );
      },
    ),
  );

  Future<void> _lookupWinner() async {
    _Type? foundType;

    for (final checkType in _Type.values) {
      for (final winSection in _winSections) {
        var foundInSection = true;
        for (final key in winSection) {
          final existing = _selection[key];
          if (existing == null || existing != checkType) {
            foundInSection = false;
            break;
          }
        }
        if (foundInSection) {
          foundType = checkType;
          break;
        }
      }
      if (foundType != null) {
        return await _showDialog('The Winner is: ${foundType.name}');
      }
    }

    if (_selection.length == _boardSize) {
      return await _showDialog("It's a draw!");
    }
  }

  Future<void> _showDialog(String text) =>
      Future<void>.delayed(_dialogDelay, () {
        if (mounted) {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              content: Text(text),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selection.clear();
                      _isCrossTurn = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('RESTART'),
                ),
              ],
            ),
          );
        }
      });
}

class const _Cell({required final Widget _child}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: const .all(_cellPadding),
    color: Colors.black,
    child: _child,
  );
}
