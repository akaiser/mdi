import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
import 'package:mdi/_prefs.dart';

typedef OnTitleBarDrag = void Function(double dx, double dy);

class const TitleBar(
  final String _title, {
  required final bool _isFixedSizeWindow,
  required final bool _isMaximizedWindow,
  required final OnTitleBarDrag _onTitleBarDrag,
  required final VoidCallback _onCloseTap,
  required final VoidCallback _onMinimizeTap,
  required final VoidCallback _onToggleMaximizeTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _TitleBarTitle(
          _title,
          onTitleBarDrag: _onTitleBarDrag,
          onToggleMaximizeTap: _onToggleMaximizeTap,
        ),
      ),
      _TitleBarButton(Icons.remove, onTap: _onMinimizeTap),
      if (!_isFixedSizeWindow) ...[
        const SizedBox(width: titleBarIconsSpace),
        _TitleBarButton(
          _isMaximizedWindow ? Icons.fullscreen : Icons.crop_square,
          onTap: _onToggleMaximizeTap,
        ),
      ],
      const SizedBox(width: titleBarIconsSpace),
      _TitleBarButton(Icons.close, onTap: _onCloseTap),
      const SizedBox(width: titleBarIconsSpace),
    ],
  );
}

class const _TitleBarTitle(
  final String _title, {
  required final OnTitleBarDrag _onTitleBarDrag,
  required final VoidCallback _onToggleMaximizeTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onPanUpdate: (details) =>
        _onTitleBarDrag(details.delta.dx, details.delta.dy),
    onDoubleTap: _onToggleMaximizeTap,
    child: ColoredBox(
      color: Colors.transparent,
      child: Padding(
        padding: titleBarTitlePadding,
        child: Text(
          _title,
          softWrap: false,
          overflow: .fade,
          style: context.tt.bodyMedium?.copyWith(color: titleBarTextColor),
        ),
      ),
    ),
  );
}

class const _TitleBarButton(
  final IconData _icon, {
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: _onTap,
    child: Icon(_icon, size: titleBarIconSize, color: Colors.white),
  );
}
