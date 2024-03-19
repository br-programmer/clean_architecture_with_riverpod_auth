import 'package:clean_architecture_with_riverpod/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('main.png'),
    );
  });
}
