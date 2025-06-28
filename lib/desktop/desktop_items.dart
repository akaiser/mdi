import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/desktop/desktop_app.dart';

class DesktopItems extends StatelessWidget {
  const DesktopItems({
    required this.groupedApps,
    required this.standaloneApps,
    required this.onItemTap,
    super.key,
  }) : assert(
         // TODO(albert): tests!
         groupedApps.length > 0 || standaloneApps.length > 0,
         'one should provide apps!',
       );

  final Map<String, List<DesktopApp>> groupedApps;
  final List<DesktopApp> standaloneApps;
  final ValueSetter<DesktopApp> onItemTap;

  @override
  Widget build(BuildContext context) => _DesktopItems(
    children: [
      ...groupedApps.entries
          .map(
            (entry) => DesktopApp(
              entry.key,
              Icons.folder,
              _DesktopItems(
                children: entry.value.map(
                  (desktopApp) => _DesktopItem(
                    desktopApp,
                    onTap: () => onItemTap(desktopApp),
                  ),
                ),
              ),
              isFolder: true,
            ),
          )
          .map(
            (desktopApp) =>
                _DesktopItem(desktopApp, onTap: () => onItemTap(desktopApp)),
          ),
      ...standaloneApps.map(
        (desktopApp) =>
            _DesktopItem(desktopApp, onTap: () => onItemTap(desktopApp)),
      ),
    ],
  );
}

class _DesktopItems extends StatelessWidget {
  const _DesktopItems({required this.children});

  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(desktopItemSpacing),
    child: Wrap(
      spacing: desktopItemSpacing,
      runSpacing: desktopItemSpacing,
      children: [...children],
    ),
  );
}

class _DesktopItem extends StatelessWidget {
  const _DesktopItem(this.desktopApp, {required this.onTap});

  final DesktopApp desktopApp;
  final VoidCallback onTap;

  Key get _itemKey => Key(desktopApp.title.toLowerCase().split(' ').join('-'));

  @override
  Widget build(BuildContext context) => GestureDetector(
    key: _itemKey,
    onTap: onTap,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Icon(desktopApp.icon, color: Colors.lightBlue, size: desktopIconSize),
          Text(
            desktopApp.title,
            style: context.tt.bodyMedium?.copyWith(
              shadows: const [Shadow(offset: Offset(1, 1), blurRadius: 6)],
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
