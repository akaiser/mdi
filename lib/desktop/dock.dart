import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/window/window.dart';

class const Dock({
  required final List<Key> _windowKeys,
  required final List<Key> _minimizedWindowKeys,
  required final Map<Key, Window> _windows,
  required final ValueSetter<Key> _onItemTap,
  super.key,
}) extends StatelessWidget {
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
          itemCount: _windowKeys.length,
          scrollDirection: .horizontal,
          itemBuilder: (context, index) {
            final key = _windowKeys[index];
            final title = _windows.title(key);
            final isMinimized = _minimizedWindowKeys.contains(key);
            return _DockItem(
              title,
              isActive: _windows.keys.last == key && !isMinimized,
              isMinimized: isMinimized,
              onItemTap: () => _onItemTap(key),
            );
          },
        ),
      ),
    ),
  );
}

class const _DockItem(
  final String _title, {
  required final bool _isActive,
  required final bool _isMinimized,
  required final VoidCallback _onItemTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: _onItemTap,
    style: OutlinedButton.styleFrom(
      backgroundColor: _isActive
          ? dockItemActiveBackgroundColor
          : dockItemInactiveBackgroundColor,
      shape: const RoundedRectangleBorder(),
      padding: const .symmetric(horizontal: 8),
    ),
    child: Text(
      _title,
      style: context.tt.bodyMedium?.copyWith(
        color: _isMinimized
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
