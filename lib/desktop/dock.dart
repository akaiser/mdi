import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
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
  Widget build(BuildContext context) => Positioned(
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
          itemBuilder: (context, index) {
            final key = windowKeys[index];
            final title = windows.title(key);
            final isMinimized = minimizedWindowKeys.contains(key);
            return _DockItem(
              title,
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
  Widget build(BuildContext context) => TextButton(
    onPressed: onItemTap,
    style: OutlinedButton.styleFrom(
      backgroundColor: isActive
          ? dockItemActiveBackgroundColor
          : dockItemInactiveBackgroundColor,
      shape: const RoundedRectangleBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    ),
    child: Text(
      title,
      style: context.tt.bodyMedium?.copyWith(
        color: isMinimized
            ? dockItemMinimizedTextColor
            : dockItemActiveTextColor,
      ),
    ),
  );
}

extension on Map<Key, Window> {
  String title(Key key) =>
      entries.singleWhere((entry) => entry.key == key).value.title;
}
