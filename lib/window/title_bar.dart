import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context.dart';
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => onTitleBarDrag(
        details.delta.dx,
        details.delta.dy,
      ),
      onDoubleTap: onToggleMaximizeTap,
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(
          padding: titleBarPadding,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.appTextTheme.h5.copyWith(
                  color: titleBarTextColor,
                ),
              ),
              Row(
                children: [
                  _TitleBarButton(
                    Icons.close,
                    onTap: onCloseTap,
                  ),
                  const SizedBox(width: titleBarIconsSpace),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleBarButton extends StatelessWidget {
  const _TitleBarButton(
    this.icon, {
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: titleBarIconSize,
        color: Colors.white,
      ),
    );
  }
}
