import 'package:flutter/foundation.dart' show Key;
import 'package:flutter_test/flutter_test.dart';
import 'package:mdi/_data.dart';
import 'package:mdi/desktop/desktop.dart';
import 'package:mdi/desktop/desktop_items.dart';
import 'package:mdi/desktop/dock.dart';
import 'package:mdi/window/window.dart';

import '../widget_tester_ext.dart';

void main() {
  group('$Desktop', () {
    testWidgets('renders nothing if no apps were passed', (tester) async {
      await tester.render(const Desktop(groupedApps: {}, standaloneApps: []));

      expect(find.byType(DesktopItems), findsNothing);
      expect(find.byType(Window), findsNothing);
      expect(find.byType(Dock), findsNothing);
    });

    testWidgets('renders $DesktopItems but no $Window and $Dock '
        'if there are no windows opened', (tester) async {
      await tester.render(
        const Desktop(groupedApps: groupedApps, standaloneApps: standaloneApps),
      );

      expect(find.byType(DesktopItems), findsOneWidget);
      expect(find.byType(Window), findsNothing);
      expect(find.byType(Dock), findsNothing);
    });

    testWidgets('renders $DesktopItems and one $Window and $Dock '
        'if one desktop item was tapped', (tester) async {
      await tester.render(
        const Desktop(groupedApps: groupedApps, standaloneApps: standaloneApps),
      );

      await tester.tap(find.byKey(const Key('games')));
      await tester.pump();

      expect(find.byType(DesktopItems), findsOneWidget);
      expect(find.byType(Window), findsOneWidget);
      expect(find.byType(Dock), findsOneWidget);
    });
  });
}
