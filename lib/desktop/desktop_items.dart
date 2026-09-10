import 'package:flutter/material.dart';
import 'package:mdi/_extensions/build_context_ext.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/desktop/desktop_app.dart';

class const DesktopItems({
  required final Map<String, List<DesktopApp>> _groupedApps,
  required final List<DesktopApp> _standaloneApps,
  required final ValueSetter<DesktopApp> _onItemTap,
  super.key,
}) extends StatelessWidget {
  this
    : assert(
        // TODO(albert): tests!
        _groupedApps.length > 0 || _standaloneApps.length > 0,
        'one should provide apps!',
      );

  @override
  Widget build(BuildContext context) => _DesktopItems(
    children: [
      ..._groupedApps.entries
          .map(
            (entry) => DesktopApp(
              entry.key,
              Icons.folder,
              _DesktopItems(
                children: entry.value.map(
                  (desktopApp) => _DesktopItem(
                    desktopApp,
                    onTap: () => _onItemTap(desktopApp),
                  ),
                ),
              ),
              isFolder: true,
            ),
          )
          .map(
            (desktopApp) =>
                _DesktopItem(desktopApp, onTap: () => _onItemTap(desktopApp)),
          ),
      ..._standaloneApps.map(
        (desktopApp) =>
            _DesktopItem(desktopApp, onTap: () => _onItemTap(desktopApp)),
      ),
    ],
  );
}

class const _DesktopItems({required final Iterable<Widget> _children})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(desktopItemSpacing),
    child: Wrap(
      spacing: desktopItemSpacing,
      runSpacing: desktopItemSpacing,
      children: [..._children],
    ),
  );
}

class const _DesktopItem(
  final DesktopApp _desktopApp, {
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  Key get _itemKey => Key(_desktopApp.title.toLowerCase().split(' ').join('-'));

  @override
  Widget build(BuildContext context) => GestureDetector(
    key: _itemKey,
    onTap: _onTap,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Icon(
            _desktopApp.icon,
            color: Colors.lightBlue,
            size: desktopIconSize,
          ),
          Text(
            _desktopApp.title,
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
