import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:mdi/_extensions/build_context.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/window/title_bar.dart';

class Window extends StatefulWidget {
  const Window({
    required Key key,
    required this.title,
    required this.app,
    required this.whenFocusRequested,
    required this.onCloseTap,
    required this.onMinimizeTap,
    required this.unHideWindowStream,
    required this.width,
    required this.height,
    required this.isFixedSize,
  }) : super(key: key);

  final String title;
  final Widget app;
  final VoidCallback whenFocusRequested;
  final VoidCallback onCloseTap;
  final VoidCallback onMinimizeTap;
  final Stream<Key> unHideWindowStream;

  final double? width;
  final double? height;
  final bool isFixedSize;

  @override
  State<Window> createState() => _WindowState();
}

class _WindowState extends State<Window> {
  final _random = Random();
  final _dx = ValueNotifier<double>(0);
  final _dy = ValueNotifier<double>(0);
  final _width = ValueNotifier<double>(0);
  final _height = ValueNotifier<double>(0);

  double _dxLast = 0;
  double _dyLast = 0;
  double _widthLast = 0;
  double _heightLast = 0;

  bool _isMinimized = false, _isMaximized = false;

  late StreamSubscription _unHideWindowSub;

  @override
  void initState() {
    super.initState();
    _unHideWindowSub = widget.unHideWindowStream
        .where((event) => widget.key! == event)
        .listen((_) => _onMinimizeTap());
  }

  @override
  void didChangeDependencies() {
    final screenSize = context.screenSize;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    _width.value = widget.width ?? screenWidth * 0.6;
    _height.value = widget.height ?? (screenHeight - dockHeight) * 0.6;
    _checkMinSize();

    _dx.value = _random.nextDouble() * (screenWidth - _width.value);
    _dy.value =
        _random.nextDouble() * (screenHeight - dockHeight - _height.value);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _unHideWindowSub.cancel();
    super.dispose();
  }

  void _onDragTop(double dy) {
    _dy.value += dy;
    _height.value -= dy;
    _checkMinSize();
  }

  void _onDragRight(double dx) {
    _width.value += dx;
    _checkMinSize();
  }

  void _onDragBottom(double dy) {
    _height.value += dy;
    _checkMinSize();
  }

  void _onDragLeft(double dx) {
    _dx.value += dx;
    _width.value -= dx;
    _checkMinSize();
  }

  void _checkMinSize() {
    if (_width.value < windowMinWidth) {
      _width.value = windowMinWidth;
    }

    if (_height.value < windowMinHeight) {
      _height.value = windowMinHeight;
    }
  }

  void _onMinimizeTap() {
    setState(() => _isMinimized = !_isMinimized);
    if (_isMinimized) {
      widget.onMinimizeTap();
    }
  }

  void _onMaximizeTap() {
    setState(() {
      if (_isMaximized) {
        _isMaximized = false;
        _width.value = _widthLast;
        _height.value = _heightLast;
        _dx.value = _dxLast;
        _dy.value = _dyLast;
      } else {
        _isMaximized = true;
        _widthLast = _width.value;
        _heightLast = _height.value;
        _dxLast = _dx.value;
        _dyLast = _dy.value;

        final screenSize = context.screenSize;
        _width.value = screenSize.width + windowOuterPadding * 2;
        _height.value = screenSize.height - dockHeight + windowOuterPadding * 2;
        _dx.value = _dy.value = -windowOuterPadding;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_width.value == 0 && _height.value == 0) {
      return const SizedBox();
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_dx, _dy]),
      builder: (context, child) => AnimatedPositioned(
        duration: windowTransitionMillis,
        left: _dx.value,
        top: _dy.value,
        child: child!,
      ),
      child: Visibility(
        maintainState: true,
        visible: !_isMinimized,
        child: Listener(
          onPointerDown: (_) => widget.whenFocusRequested(),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([_width, _height]),
                builder: (context, child) => AnimatedContainer(
                  duration: windowTransitionMillis,
                  width: _width.value,
                  height: _height.value,
                  child: child,
                ),
                child: _WindowDecoration(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleBar(
                        widget.title,
                        isFixedSizeWindow: widget.isFixedSize,
                        isMaximizedWindow: _isMaximized,
                        onTitleBarDrag: (dx, dy) {
                          _dx.value += dx;
                          _dy.value += dy;
                        },
                        onCloseTap: widget.onCloseTap,
                        onMinimizeTap: _onMinimizeTap,
                        onMaximizeTap: _onMaximizeTap,
                      ),
                      const ColoredBox(
                        color: windowBodySeparatorColor,
                        child: SizedBox(height: 1),
                      ),
                      Expanded(
                        child: ColoredBox(
                          color: windowBodyColor,
                          child: widget.app,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.isFixedSize) ...[
                // left
                _BorderDragArea(
                  onHorizontalDragUpdate: (details) =>
                      _onDragLeft(details.delta.dx),
                  right: null,
                ),
                // right
                _BorderDragArea(
                  onHorizontalDragUpdate: (details) =>
                      _onDragRight(details.delta.dx),
                  left: null,
                ),
                // top
                _BorderDragArea(
                  onVerticalDragUpdate: (details) =>
                      _onDragTop(details.delta.dy),
                  bottom: null,
                ),
                // bottom
                _BorderDragArea(
                  onVerticalDragUpdate: (details) =>
                      _onDragBottom(details.delta.dy),
                  top: null,
                ),
                // top-left
                _CornerDragArea(
                  onPanUpdate: (details) {
                    _onDragTop(details.delta.dy);
                    _onDragLeft(details.delta.dx);
                  },
                  right: null,
                  bottom: null,
                ),
                // top-right
                _CornerDragArea(
                  onPanUpdate: (details) {
                    _onDragTop(details.delta.dy);
                    _onDragRight(details.delta.dx);
                  },
                  bottom: null,
                  left: null,
                ),
                // bottom-right
                _CornerDragArea(
                  onPanUpdate: (details) {
                    _onDragBottom(details.delta.dy);
                    _onDragRight(details.delta.dx);
                  },
                  top: null,
                  left: null,
                ),
                // bottom-left
                _CornerDragArea(
                  onPanUpdate: (details) {
                    _onDragBottom(details.delta.dy);
                    _onDragLeft(details.delta.dx);
                  },
                  top: null,
                  right: null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowDecoration extends StatelessWidget {
  const _WindowDecoration({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(windowOuterPadding),
      child: DecoratedBox(
        decoration: windowDecoration,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
            borderRadius: windowBorderRadius,
            child: child,
          ),
        ),
      ),
    );
  }
}

abstract class _DragArea extends StatelessWidget {
  const _DragArea(
    this.left,
    this.top,
    this.right,
    this.bottom,
    Key? key,
  ) : super(key: key);

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
}

class _BorderDragArea extends _DragArea {
  const _BorderDragArea({
    this.onHorizontalDragUpdate,
    this.onVerticalDragUpdate,
    double? left = 0,
    double? top = 0,
    double? right = 0,
    double? bottom = 0,
    Key? key,
  }) : super(left, top, right, bottom, key);

  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragUpdateCallback? onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) {
    final isHorizontal = right == null || left == null;
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onVerticalDragUpdate: onVerticalDragUpdate,
        child: MouseRegion(
          cursor: isHorizontal
              ? SystemMouseCursors.resizeLeftRight
              : SystemMouseCursors.resizeUpDown,
          child: SizedBox(
            width: isHorizontal ? 8 : null,
            height: isHorizontal ? null : 8,
          ),
        ),
      ),
    );
  }
}

class _CornerDragArea extends _DragArea {
  const _CornerDragArea({
    required this.onPanUpdate,
    double? left = 0,
    double? top = 0,
    double? right = 0,
    double? bottom = 0,
    Key? key,
  }) : super(left, top, right, bottom, key);

  final GestureDragUpdateCallback onPanUpdate;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: MouseRegion(
          cursor: bottom == null && right == null || top == null && left == null
              ? SystemMouseCursors.resizeUpLeftDownRight
              : SystemMouseCursors.resizeUpRightDownLeft,
          child: const SizedBox(height: 12, width: 12),
        ),
      ),
    );
  }
}
