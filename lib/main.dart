import 'dart:async' show Future, runZonedGuarded;
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:mdi/_data.dart';
import 'package:mdi/_prefs.dart';
import 'package:mdi/_util/image.dart';
import 'package:mdi/desktop/desktop.dart';

Future<void> main() async => runZonedGuarded<Future<void>>(
  () async {
    WidgetsFlutterBinding.ensureInitialized();
    await precache(mainBackgroundImage);
    runApp(const _App());
  },
  (error, stack) =>
      log('Some explosion here...', error: error, stackTrace: stack),
);

class _App extends MaterialApp {
  const _App()
    : super(
        title: appName,
        home: const Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: mainBackgroundImage,
              ),
            ),
            child: SafeArea(
              child: Desktop(
                groupedApps: groupedApps,
                standaloneApps: standaloneApps,
              ),
            ),
          ),
        ),
      );
}
