import 'package:flutter/material.dart' show Icons;
import 'package:mdi/apps/auto_count.dart';
import 'package:mdi/apps/calculator.dart';
import 'package:mdi/apps/manual_count.dart';
import 'package:mdi/apps/some_grid_view.dart';
import 'package:mdi/apps/some_split_view.dart';
import 'package:mdi/apps/terminal.dart';
import 'package:mdi/apps/tik_tak_toe.dart';
import 'package:mdi/apps/use_keyboard.dart';
import 'package:mdi/desktop/desktop_app.dart';

const groupedApps = <String, List<DesktopApp>>{
  'Games': [
    DesktopApp(
      'TikTakToe',
      Icons.insert_drive_file,
      TikTakToe(),
    ),
    DesktopApp(
      'Use Keyboard',
      Icons.keyboard,
      UseKeyboard(),
    ),
  ],
  'Misc': [
    DesktopApp(
      'Some Split View',
      Icons.insert_drive_file,
      SomeSplitView(),
    ),
    DesktopApp(
      'Some Grid View',
      Icons.insert_drive_file,
      SomeGridView(),
    ),
  ],
};

const standaloneApps = <DesktopApp>[
  DesktopApp(
    'Auto Counter',
    Icons.insert_drive_file,
    AutoCount(),
  ),
  DesktopApp(
    'Manual Counter',
    Icons.insert_drive_file,
    ManualCount(),
  ),
  DesktopApp(
    'Calculator',
    Icons.insert_drive_file,
    Calculator(),
    width: 234,
    height: 330,
    isFixedSize: true,
  ),
  // TODO(albert): do not forget about the Editor!
  DesktopApp(
    'Terminal',
    Icons.text_snippet,
    Terminal(),
  ),
];
