import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mdi/desktop/desktop_app.dart';
import 'package:mdi/desktop/desktop_items.dart';
import 'package:mdi/desktop/dock.dart';
import 'package:mdi/window/window.dart';

class Desktop extends StatefulWidget {
  const Desktop({
    required this.groupedApps,
    required this.standaloneApps,
    super.key,
  });

  final Map<String, List<DesktopApp>> groupedApps;
  final List<DesktopApp> standaloneApps;

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  var _shouldRebuild = false;
  final _windowKeys = <Key>[];
  final _minimizedWindowKeys = <Key>[];
  final _windows = <Key, Window>{};

  late final StreamController<Key> _unHideWindowNotifier;

  @override
  void initState() {
    super.initState();
    _unHideWindowNotifier = StreamController<Key>.broadcast();
  }

  @override
  void dispose() {
    _unHideWindowNotifier.close();
    super.dispose();
  }

  void _bringToFront(Key key) {
    if (_windows.keys.last != key) {
      final window = _windows.remove(key);
      if (window != null) {
        _windows[key] = window;
        _shouldRebuild = true;
      }
    }
  }

  void _unMinimize(Key key) {
    if (_minimizedWindowKeys.contains(key)) {
      _unHideWindowNotifier.sink.add(key);
      _minimizedWindowKeys.remove(key);
      _shouldRebuild = true;
    }
    _bringToFront(key);
  }

  void _rebuildOnChange() {
    if (_shouldRebuild) {
      setState(() => _shouldRebuild = false);
    }
  }

  String _windowTitle(DesktopApp desktopApp) {
    final instances = _windows.entries
        .where((entry) => entry.value.title == desktopApp.title)
        .length;

    return instances > 0
        ? '${desktopApp.title} [$instances]'
        : desktopApp.title;
  }

  void _addWindow(DesktopApp desktopApp) {
    final key = UniqueKey();
    final window = Window(
      key: key,
      title: _windowTitle(desktopApp),
      app: desktopApp.app,
      whenFocusRequested: () {
        _bringToFront(key);
        _rebuildOnChange();
      },
      onCloseTap: () => setState(() {
        _windowKeys.remove(key);
        _windows.remove(key);
      }),
      onMinimizeTap: () => setState(
        () => _minimizedWindowKeys.add(key),
      ),
      unHideWindowStream: _unHideWindowNotifier.stream,
      width: desktopApp.width,
      height: desktopApp.height,
      isFixedSize: desktopApp.isFixedSize,
    );
    setState(() {
      _windowKeys.add(key);
      _windows[key] = window;
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedApps = widget.groupedApps;
    final standaloneApps = widget.standaloneApps;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (groupedApps.isNotEmpty || standaloneApps.isNotEmpty)
          DesktopItems(
            groupedApps: groupedApps,
            standaloneApps: standaloneApps,
            onItemTap: _addWindow,
          ),
        ..._windows.values,
        if (_windows.isNotEmpty)
          ExcludeFocus(
            child: Dock(
              windowKeys: _windowKeys,
              minimizedWindowKeys: _minimizedWindowKeys,
              windows: _windows,
              onItemTap: (key) {
                _unMinimize(key);
                _rebuildOnChange();
              },
            ),
          ),
      ],
    );
  }
}
