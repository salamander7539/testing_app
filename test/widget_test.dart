import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_flutter/colors.dart';
import 'package:test_task_flutter/random_number_generator.dart';
import 'package:test_task_flutter/yellow_screen.dart';

void main() {
  testWidgets('Проверяем, что при тапе по кнопке число от 0 до 49 отображается синим цветом', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: YellowScreen(generator: RandomNumberGeneratorImpl())));

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(
        find.byWidgetPredicate(
              (Widget widget) => widget is Container && widget.color == yellowColor,
        ),
        findsOneWidget);
    final randomButton = find.text('Случайное число');
    expect(randomButton, findsOneWidget);
    await tester.tap(randomButton);
    await tester.pumpAndSettle();

    expect(
        (tester.firstWidget(find.byWidgetPredicate(
                (widget) => widget is Text && (int.parse(widget.data!) >= 0 || int.parse(widget.data!) < 50))) as Text)
            .style
            ?.color,
        blueColor);
  });
}
