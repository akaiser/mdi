import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class SimpleSplitView extends StatelessWidget {
  const SimpleSplitView({
    required this.left,
    required this.right,
    this.dividerWidth = 4,
    this.dividerColor = const Color.fromRGBO(78, 74, 82, 1),
    Key? key,
  }) : super(key: key);

  final Widget left;
  final Widget right;
  final double dividerWidth;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => _SimpleSplitView(
        left: left,
        right: right,
        dividerWidth: dividerWidth,
        dividerColor: dividerColor,
        maxWidth: constrains.maxWidth,
      ),
    );
  }
}

class _SimpleSplitView extends StatefulWidget {
  const _SimpleSplitView({
    required this.left,
    required this.right,
    required this.dividerWidth,
    required this.dividerColor,
    required this.maxWidth,
    Key? key,
  })  : leftWidthMax = maxWidth - dividerWidth,
        super(key: key);

  final Widget left;
  final Widget right;
  final double dividerWidth;
  final Color dividerColor;
  final double maxWidth;

  final double leftWidthMax;

  @override
  _SimpleSplitViewState createState() => _SimpleSplitViewState();
}

class _SimpleSplitViewState extends State<_SimpleSplitView> {
  double _leftWidth = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      setState(() => _leftWidth = widget.leftWidthMax / 3);
    });
  }

  double get _leftWidthCalculated {
    return widget.leftWidthMax - _leftWidth < 0
        ? widget.leftWidthMax
        : _leftWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: _leftWidthCalculated,
          child: widget.left,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.resizeLeftRight,
          child: GestureDetector(
            onPanUpdate: (details) {
              var leftWidthTemp = _leftWidth + details.delta.dx;
              if (leftWidthTemp < 0) {
                leftWidthTemp = 0;
              } else if (leftWidthTemp > widget.leftWidthMax) {
                leftWidthTemp = widget.leftWidthMax;
              }
              if (_leftWidth != leftWidthTemp) {
                setState(() => _leftWidth = leftWidthTemp);
              }
            },
            child: ColoredBox(
              color: widget.dividerColor,
              child: SizedBox(width: widget.dividerWidth),
            ),
          ),
        ),
        Expanded(child: widget.right),
      ],
    );
  }
}
