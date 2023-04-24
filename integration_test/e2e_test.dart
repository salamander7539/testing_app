import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_task_flutter/colors.dart';
import 'package:test_task_flutter/green_screen.dart';
import 'package:test_task_flutter/home_screen.dart';
import 'package:test_task_flutter/keys.dart';
import 'package:test_task_flutter/yellow_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'E2E test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      final greenButtonFinder = find.text('зеленый');
      await tester.tap(greenButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(GreenScreen), findsOneWidget);

      final greenScreenFinder = find.text('Зеленый экран');
      Text text = tester.firstWidget(greenScreenFinder);
      expect(text.data, 'Зеленый экран');
      expect(text.style?.color, Colors.white);

      expect(
          find.byWidgetPredicate(
                (Widget widget) => widget is Container && widget.color == greenColor,
          ),
          findsOneWidget);

      final backFromGreen = find.byIcon(Icons.arrow_back);
      await tester.ensureVisible(backFromGreen);
      await tester.tap(backFromGreen);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      final yellowButtonFinder = find.text('желтый');
      await tester.tap(yellowButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(YellowScreen), findsOneWidget);
      final emptyCount = find.descendant(
          of: find.byKey(const Key(Keys.randomNumberContainerKey)),
          matching: find.byWidgetPredicate((widget) => widget is SizedBox));
      expect(emptyCount, findsOneWidget);

      await tester.tap(find.text('Случайное число'));
      await tester.pumpAndSettle();

      final newCount =  find.descendant(
          of: find.byKey(const Key(Keys.randomNumberContainerKey)),
          matching: find.byWidgetPredicate((widget) => widget is Text && widget.data != ''));
      expect(newCount, findsOneWidget);

      final backFromYellow = find.byIcon(Icons.arrow_back);
      await tester.ensureVisible(backFromYellow);
      await tester.tap(backFromYellow);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      await Future.delayed(const Duration(seconds: 5));
    },
  );
}
