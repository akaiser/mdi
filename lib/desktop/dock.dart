import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/window/window.dart';

class Dock extends StatelessWidget {
  const Dock({
    required this.windowKeys,
    required this.minimizedWindowKeys,
    required this.windows,
    required this.onItemTap,
    super.key,
  });

  final List<Key> windowKeys;
  final List<Key> minimizedWindowKeys;
  final Map<Key, Window> windows;
  final ValueSetter<Key> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ColoredBox(
        color: dockBackgroundColor,
        child: SizedBox(
          height: dockHeight,
          child: ListView.builder(
            itemCount: windowKeys.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final key = windowKeys[index];
              final isMinimized = minimizedWindowKeys.contains(key);
              return _DockItem(
                windows[key]!.title,
                isActive: windows.keys.last == key && !isMinimized,
                isMinimized: isMinimized,
                onItemTap: () => onItemTap(key),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  const _DockItem(
    this.title, {
    required this.isActive,
    required this.isMinimized,
    required this.onItemTap,
  });

  final String title;
  final bool isActive;
  final bool isMinimized;
  final VoidCallback onItemTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onItemTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive
            ? dockItemActiveBackgroundColor
            : dockItemInactiveBackgroundColor,
        shape: const RoundedRectangleBorder(),
      ),
      child: Text(
        title,
        style: context.appTextTheme.h5.copyWith(
          color: isMinimized
              ? dockItemMinimizedTextColor
              : dockItemActiveTextColor,
        ),
      ),
    );
  }
}
