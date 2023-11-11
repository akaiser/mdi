import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
import 'package:mdi/_prefs.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(
    this.title, {
    required this.isFixedSizeWindow,
    required this.isMaximizedWindow,
    required this.onTitleBarDrag,
    required this.onCloseTap,
    required this.onMinimizeTap,
    required this.onToggleMaximizeTap,
    super.key,
  });

  final String title;

  final bool isFixedSizeWindow;
  final bool isMaximizedWindow;
  final void Function(double dx, double dy) onTitleBarDrag;
  final VoidCallback onCloseTap;
  final VoidCallback onMinimizeTap;
  final VoidCallback onToggleMaximizeTap;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: _TitleBarTitle(
              title,
              onTitleBarDrag: onTitleBarDrag,
              onToggleMaximizeTap: onToggleMaximizeTap,
            ),
          ),
          _TitleBarButton(
            Icons.remove,
            onTap: onMinimizeTap,
          ),
          if (!isFixedSizeWindow) ...[
            const SizedBox(width: titleBarIconsSpace),
            _TitleBarButton(
              isMaximizedWindow ? Icons.fullscreen : Icons.crop_square,
              onTap: onToggleMaximizeTap,
            ),
          ],
          const SizedBox(width: titleBarIconsSpace),
          _TitleBarButton(
            Icons.close,
            onTap: onCloseTap,
          ),
          const SizedBox(width: titleBarIconsSpace),
        ],
      );
}

class _TitleBarTitle extends StatelessWidget {
  const _TitleBarTitle(
    this.title, {
    required this.onTitleBarDrag,
    required this.onToggleMaximizeTap,
  });

  final String title;
  final void Function(double dx, double dy) onTitleBarDrag;
  final VoidCallback onToggleMaximizeTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanUpdate: (details) => onTitleBarDrag(
          details.delta.dx,
          details.delta.dy,
        ),
        onDoubleTap: onToggleMaximizeTap,
        child: ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: titleBarTitlePadding,
            child: Text(
              title,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: context.tt.bodyMedium?.copyWith(color: titleBarTextColor),
            ),
          ),
        ),
      );
}

class _TitleBarButton extends StatelessWidget {
  const _TitleBarButton(
    this.icon, {
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          size: titleBarIconSize,
          color: Colors.white,
        ),
      );
}
