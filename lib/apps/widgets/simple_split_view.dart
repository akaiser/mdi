import 'package:flutter/widgets.dart';

class const SimpleSplitView({
  required final Widget _left,
  required final Widget _right,
  final double _dividerWidth = 4,
  final Color _dividerColor = const Color.fromRGBO(78, 74, 82, 1),
  final bool _leftViewVisible = true,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constrains) => _SimpleSplitView(
      left: _left,
      right: _right,
      dividerWidth: _dividerWidth,
      dividerColor: _dividerColor,
      leftViewVisible: _leftViewVisible,
      leftWidthMax: constrains.maxWidth - _dividerWidth,
    ),
  );
}

class const _SimpleSplitView({
  required final Widget _left,
  required final Widget _right,
  required final double _dividerWidth,
  required final Color _dividerColor,
  required final bool _leftViewVisible,
  required final double _leftWidthMax,
}) extends StatefulWidget {
  @override
  _SimpleSplitViewState createState() => _SimpleSplitViewState();
}

class _SimpleSplitViewState extends State<_SimpleSplitView> {
  late final ValueNotifier<double> _leftWidthNotifier;

  @override
  void initState() {
    super.initState();
    _leftWidthNotifier = ValueNotifier(widget._leftWidthMax / 3.5);
  }

  @override
  void dispose() {
    _leftWidthNotifier.dispose();
    super.dispose();
  }

  double _leftWidthCalculated(double leftWidth) =>
      widget._leftWidthMax - leftWidth < 0 ? widget._leftWidthMax : leftWidth;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      if (widget._leftViewVisible)
        Row(
          crossAxisAlignment: .stretch,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: _leftWidthNotifier,
              builder: (context, leftWidth, child) {
                final leftWidthCalculated = _leftWidthCalculated(leftWidth);
                return SizedBox(
                  width: leftWidthCalculated,
                  child: leftWidthCalculated > 0 ? child : null,
                );
              },
              child: widget._left,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final leftWidthCurrent = _leftWidthNotifier.value;
                  var leftWidthTemp = leftWidthCurrent + details.delta.dx;
                  if (leftWidthTemp < 0) {
                    leftWidthTemp = 0;
                  } else if (leftWidthTemp > widget._leftWidthMax) {
                    leftWidthTemp = widget._leftWidthMax;
                  }
                  if (leftWidthCurrent != leftWidthTemp) {
                    _leftWidthNotifier.value = leftWidthTemp;
                  }
                },
                child: ColoredBox(
                  color: widget._dividerColor,
                  child: SizedBox(width: widget._dividerWidth),
                ),
              ),
            ),
          ],
        ),
      Expanded(child: widget._right),
    ],
  );
}
