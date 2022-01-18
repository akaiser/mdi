import 'dart:async' show runZonedGuarded;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mdi/apps/some_grid_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test',
      home: Scaffold(
        body: SomeGridView(),
      ),
    );
  }
}
