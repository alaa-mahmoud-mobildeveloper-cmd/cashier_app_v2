import 'package:cashier_app_v2/features/workers/presentation/widgets/advances_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('worker advances panel shows the empty state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AdvancesListSection(advances: [])),
      ),
    );

    expect(find.text('السلف (0)'), findsOneWidget);
    expect(find.text('لا توجد سلف'), findsOneWidget);
  });
}
