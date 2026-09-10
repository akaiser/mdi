import 'package:flutter/widgets.dart';

const _cursorBlinkDuration = Duration(milliseconds: 400);

class const Cursor({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Animated(
    _cursorBlinkDuration,
    onInit: (controller) => controller.repeat(reverse: true),
    child: const Text('▌'),
  );
}

class const _Animated(
  final Duration _animationDuration, {
  required final void Function(AnimationController controller) _onInit,
  required final Widget _child,
}) extends StatefulWidget {
  @override
  _AnimatedState createState() => _AnimatedState();
}

class _AnimatedState extends State<_Animated>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget._animationDuration,
  );

  @override
  void initState() {
    super.initState();
    widget._onInit(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _controller, child: widget._child);
}
