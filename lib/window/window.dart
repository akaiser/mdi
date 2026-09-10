import 'dart:async';
import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/window/title_bar.dart';

class const Window({
  required final String title,
  required final Widget _app,
  required final VoidCallback _whenFocusRequested,
  required final VoidCallback _onCloseTap,
  required final VoidCallback _onMinimizeTap,
  required final Stream<Key> _unHideWindowStream,
  required final double? _width,
  required final double? _height,
  required final bool _isFixedSize,
  required super.key,
}) extends StatefulWidget {
  @override
  State<Window> createState() => _WindowState();
}

class _WindowState extends State<Window> {
  final _random = Random();
  double _dx = 0, _dxLast = 0;
  double _dy = 0, _dyLast = 0;
  double _width = 0, _widthLast = 0;
  double _height = 0, _heightLast = 0;

  var _isMinimized = false, _isMaximized = false;

  late final StreamSubscription<Key> _unHideWindowSubscription;

  (double, double) get _availableSize {
    final screenSize = context.screenSize;
    return (
      screenSize.width + windowOuterPaddingTimes2,
      screenSize.height - dockHeight + windowOuterPaddingTimes2,
    );
  }

  @override
  void initState() {
    super.initState();

    _unHideWindowSubscription = widget._unHideWindowStream
        .where((event) => widget.key == event)
        .listen((_) => _toggleMinimize());

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final (availableWidth, availableHeight) = _availableSize;
      setState(() {
        _width = widget._width ?? availableWidth * 0.6;
        _height = widget._height ?? availableHeight * 0.6;
        _checkMinSize();

        _dx = _random.nextDouble() * (availableWidth - _width);
        _dy = _random.nextDouble() * (availableHeight - _height);
      });
    });
  }

  @override
  void dispose() {
    unawaited(_unHideWindowSubscription.cancel());
    super.dispose();
  }

  void _onDragTop(double dy) {
    _dy += dy;
    _height -= dy;
    _checkMinSize();
  }

  void _onDragRight(double dx) {
    _width += dx;
    _checkMinSize();
  }

  void _onDragBottom(double dy) {
    _height += dy;
    _checkMinSize();
  }

  void _onDragLeft(double dx) {
    _dx += dx;
    _width -= dx;
    _checkMinSize();
  }

  void _checkMinSize() {
    if (_width < windowMinWidth) {
      _width = windowMinWidth;
    }

    if (_height < windowMinHeight) {
      _height = windowMinHeight;
    }
  }

  void _toggleMinimize() {
    setState(() => _isMinimized = !_isMinimized);
    if (_isMinimized) {
      widget._onMinimizeTap();
    }
  }

  void _toggleMaximize() {
    setState(() {
      if (_isMaximized) {
        _isMaximized = false;
        _width = _widthLast;
        _height = _heightLast;
        _dx = _dxLast;
        _dy = _dyLast;
      } else {
        _isMaximized = true;
        _widthLast = _width;
        _heightLast = _height;
        _dxLast = _dx;
        _dyLast = _dy;

        final (availableWidth, availableHeight) = _availableSize;
        _width = availableWidth;
        _height = availableHeight;
        _dx = _dy = -windowOuterPadding;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_width == 0 && _height == 0) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      left: _dx,
      top: _dy,
      duration: windowTransitionMillis,
      child: Visibility(
        maintainState: true,
        visible: !_isMinimized,
        child: Listener(
          onPointerDown: (_) => widget._whenFocusRequested(),
          child: Stack(
            children: [
              AnimatedContainer(
                width: _width,
                height: _height,
                duration: windowTransitionMillis,
                padding: const .all(windowOuterPadding),
                child: _WindowDecoration(
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      TitleBar(
                        widget.title,
                        isFixedSizeWindow: widget._isFixedSize,
                        isMaximizedWindow: _isMaximized,
                        onTitleBarDrag: (dx, dy) => setState(() {
                          _dx += dx;
                          _dy += dy;
                        }),
                        onCloseTap: widget._onCloseTap,
                        onMinimizeTap: _toggleMinimize,
                        onToggleMaximizeTap: _toggleMaximize,
                      ),
                      const ColoredBox(
                        color: windowBodySeparatorColor,
                        child: SizedBox(height: 1),
                      ),
                      Expanded(
                        child: ColoredBox(
                          color: windowBodyColor,
                          child: widget._app,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget._isFixedSize) ...[
                // left
                _BorderDragArea(
                  onHorizontalDragUpdate: (details) =>
                      setState(() => _onDragLeft(details.delta.dx)),
                  right: null,
                ),
                // right
                _BorderDragArea(
                  onHorizontalDragUpdate: (details) =>
                      setState(() => _onDragRight(details.delta.dx)),
                  left: null,
                ),
                // top
                _BorderDragArea(
                  onVerticalDragUpdate: (details) =>
                      setState(() => _onDragTop(details.delta.dy)),
                  bottom: null,
                ),
                // bottom
                _BorderDragArea(
                  onVerticalDragUpdate: (details) =>
                      setState(() => _onDragBottom(details.delta.dy)),
                  top: null,
                ),
                // top-left
                _CornerDragArea(
                  onPanUpdate: (details) => setState(() {
                    _onDragTop(details.delta.dy);
                    _onDragLeft(details.delta.dx);
                  }),
                  right: null,
                  bottom: null,
                ),
                // top-right
                _CornerDragArea(
                  onPanUpdate: (details) => setState(() {
                    _onDragTop(details.delta.dy);
                    _onDragRight(details.delta.dx);
                  }),
                  bottom: null,
                  left: null,
                ),
                // bottom-right
                _CornerDragArea(
                  onPanUpdate: (details) => setState(() {
                    _onDragBottom(details.delta.dy);
                    _onDragRight(details.delta.dx);
                  }),
                  top: null,
                  left: null,
                ),
                // bottom-left
                _CornerDragArea(
                  onPanUpdate: (details) => setState(() {
                    _onDragBottom(details.delta.dy);
                    _onDragLeft(details.delta.dx);
                  }),
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

class const _WindowDecoration({required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: windowDecoration,
    child: Padding(
      padding: const .all(1),
      child: ClipRRect(borderRadius: windowBorderRadius, child: child),
    ),
  );
}

class const _BorderDragArea({
  final GestureDragUpdateCallback? _onHorizontalDragUpdate,
  final GestureDragUpdateCallback? _onVerticalDragUpdate,
  final double? _left = 0,
  final double? _top = 0,
  final double? _right = 0,
  final double? _bottom = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isHorizontal = _right == null || _left == null;
    return Positioned(
      left: _left,
      top: _top,
      right: _right,
      bottom: _bottom,
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onVerticalDragUpdate: _onVerticalDragUpdate,
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

class const _CornerDragArea({
  required final GestureDragUpdateCallback _onPanUpdate,
  final double? _left = 0,
  final double? _top = 0,
  final double? _right = 0,
  final double? _bottom = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Positioned(
    left: _left,
    top: _top,
    right: _right,
    bottom: _bottom,
    child: GestureDetector(
      onPanUpdate: _onPanUpdate,
      child: MouseRegion(
        cursor:
            _bottom == null && _right == null || _top == null && _left == null
            ? SystemMouseCursors.resizeUpLeftDownRight
            : SystemMouseCursors.resizeUpRightDownLeft,
        child: const SizedBox(height: 12, width: 12),
      ),
    ),
  );
}
