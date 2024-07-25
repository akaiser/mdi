import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/apps/_terminal/cursor.dart';

const _promptIntro = 'Welcome to Dummy Terminal (v0.0.1)';
const _promptPrefix = r'user@local ~ $ ';
const _textStyle = TextStyle(fontSize: 14, color: Colors.white);

class Terminal extends StatefulWidget {
  const Terminal({super.key});

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  late final _focusNode = FocusNode()..requestFocus();
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        // TODO(albert): check if this can be done on higher level
        // when window receives focus for example.
        onEnter: (_) => _focusNode.requestFocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: DefaultTextStyle.merge(
            style: _textStyle,
            child: ScrollbarTheme(
              data: const ScrollbarThemeData(
                thumbColor: WidgetStatePropertyAll(titleBarTextColor),
                thickness: WidgetStatePropertyAll(5),
              ),
              child: _Terminal(
                focusNode: _focusNode,
                scrollController: _scrollController,
              ),
            ),
          ),
        ),
      );
}

class _Terminal extends StatefulWidget {
  const _Terminal({
    required this.focusNode,
    required this.scrollController,
  });

  final FocusNode focusNode;
  final ScrollController scrollController;

  @override
  State<_Terminal> createState() => __TerminalState();
}

class __TerminalState extends State<_Terminal> {
  final _lines = <String>[];
  final _chars = <String>[_promptPrefix];

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async => widget.scrollController.jumpTo(
        widget.scrollController.position.maxScrollExtent,
      ),
    );
  }

  void _onKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        setState(() {
          _lines.add(_chars.join());
          _chars
            ..clear()
            ..add(_promptPrefix);
        });
        _scrollToBottom();
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_chars.length > 1) {
          setState(_chars.removeLast);
        }
      } else {
        final character = event.character;
        if (character != null) {
          setState(() => _chars.add(character));
          //_scrollToBottom();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => KeyboardListener(
        focusNode: widget.focusNode,
        onKeyEvent: _onKeyEvent,
        child: ListView(
          controller: widget.scrollController,
          children: [
            const Text(_promptIntro),
            const SizedBox(height: 8),
            ..._lines.map(Text.new),
            Wrap(
              children: [
                Text(_chars.join()),
                const Cursor(),
              ],
            ),
          ],
        ),
      );
}
