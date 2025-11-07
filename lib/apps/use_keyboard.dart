import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/apps/widgets/simple_grid_view.dart';

const xCount = 41;
const yCount = 31;

class UseKeyboard extends StatefulWidget {
  const UseKeyboard();

  @override
  State<UseKeyboard> createState() => _UseKeyboardState();
}

class _UseKeyboardState extends State<UseKeyboard> {
  late final _focusNode = FocusNode();

  int xCurrent = xCount ~/ 2;
  int yCurrent = yCount ~/ 2;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          if (yCurrent != 0) {
            setState(() => yCurrent -= 1);
          }
        case LogicalKeyboardKey.arrowDown:
          if (yCurrent != yCount - 1) {
            setState(() => yCurrent += 1);
          }
        case LogicalKeyboardKey.arrowLeft:
          if (xCurrent != 0) {
            setState(() => xCurrent -= 1);
          }
        case LogicalKeyboardKey.arrowRight:
          if (xCurrent != xCount - 1) {
            setState(() => xCurrent += 1);
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    // TODO(albert): check if this can be done on higher level
    // when window receives focus for example.
    onEnter: (_) => _focusNode.requestFocus(),
    child: KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _onKeyEvent,
      child: SimpleGridView(
        columnCount: xCount,
        rowCount: yCount,
        cellBuilder: (context, xIndex, yIndex) =>
            xIndex == xCurrent && yIndex == yCurrent
            ? const ColoredBox(color: Colors.red)
            : const SizedBox(),
      ),
    ),
  );
}
