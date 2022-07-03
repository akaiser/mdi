import 'dart:async' show Future, runZonedGuarded;
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:mdi/_data.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/_util/image.dart';
import 'package:mdi/desktop/desktop.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await precache(mainBackgroundImage);

  runZonedGuarded<void>(
    () => runApp(const _App()),
    (error, stack) => log(
      'Some explosion here...',
      error: error,
      stackTrace: stack,
    ),
  );
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MDI',
      home: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: mainBackgroundImage,
            ),
          ),
          child: Desktop(
            groupedApps: groupedApps,
            standaloneApps: standaloneApps,
          ),
        ),
      ),
    );
  }
}
