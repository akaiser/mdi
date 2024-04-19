import 'package:flutter/widgets.dart';

const _cursorBlinkDuration = Duration(milliseconds: 400);

class Cursor extends StatelessWidget {
  const Cursor();

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
