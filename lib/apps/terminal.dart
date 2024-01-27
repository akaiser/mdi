import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mdi/_prefs.dart';

const _promptIntro = 'Welcome to Dummy Terminal (v0.0.1)';
const _promptPrefix = r'user@local ~ $ ';
const _textStyle = TextStyle(fontSize: 14, color: Colors.white);

const _cursorBlinkDuration = Duration(milliseconds: 400);

class Terminal extends StatefulWidget {
  const Terminal({super.key});

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  late final _scrollController = ScrollController();
  late final _focus = FocusNode();

  final _lines = <String>[];
  final _chars = <String>[_promptPrefix];

  @override
  void dispose() {
    _scrollController.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async => _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      ),
    );
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
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
  Widget build(BuildContext context) => MouseRegion(
        // TODO(albert): check if this can be done on higher level
        // when window receives focus for example.
        onEnter: (_) => _focus.requestFocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: RawKeyboardListener(
            focusNode: _focus,
            autofocus: true,
            onKey: _onKey,
            child: DefaultTextStyle.merge(
              style: _textStyle,
              child: ScrollbarTheme(
                data: const ScrollbarThemeData(
                  thumbColor: MaterialStatePropertyAll(titleBarTextColor),
                  thickness: MaterialStatePropertyAll(5),
                ),
                child: ListView(
                  controller: _scrollController,
                  children: [
                    const Text(_promptIntro),
                    const SizedBox(height: 8),
                    ..._lines.map(Text.new),
                    Wrap(
                      children: [
                        ..._chars.map(Text.new),
                        const _Cursor(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _Cursor extends StatelessWidget {
  const _Cursor();

  @override
  Widget build(BuildContext context) => _Animated(
        _cursorBlinkDuration,
        onInit: (controller) => controller.repeat(reverse: true),
        child: const Text('▌'),
      );
}

class _Animated extends StatefulWidget {
  const _Animated(
    this.animationDuration, {
    required this.onInit,
    required this.child,
  });

  final Duration animationDuration;
  final void Function(AnimationController controller) onInit;
  final Widget child;

  @override
  _AnimatedState createState() => _AnimatedState();
}

class _AnimatedState extends State<_Animated>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
  );

  @override
  void initState() {
    super.initState();
    widget.onInit(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _controller,
        child: widget.child,
      );
}
