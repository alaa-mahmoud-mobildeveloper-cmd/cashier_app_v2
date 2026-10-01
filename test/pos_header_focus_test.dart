import 'package:cashier_app_v2/features/pos/presentation/widgets/pos_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'retains the last input focus on outside taps and switches only to another input',
    (tester) async {
      final searchController = TextEditingController();
      final searchFocusNode = FocusNode();
      final otherFocusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                PosHeader(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  onSearch: (_) {},
                ),
                TextField(
                  key: const ValueKey('other-input'),
                  focusNode: otherFocusNode,
                  onTapOutside: (_) {},
                ),
                Expanded(
                  child: GestureDetector(
                    key: const ValueKey('blank-area'),
                    behavior: HitTestBehavior.opaque,
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(searchFocusNode.hasFocus, isTrue);

      await tester.tap(
        find.byKey(const ValueKey('blank-area')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pumpAndSettle();
      expect(searchFocusNode.hasFocus, isTrue);

      await tester.tap(
        find.byKey(const ValueKey('other-input')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pumpAndSettle();
      expect(otherFocusNode.hasFocus, isTrue);
      expect(searchFocusNode.hasFocus, isFalse);

      await tester.tap(
        find.byKey(const ValueKey('blank-area')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pumpAndSettle();
      expect(otherFocusNode.hasFocus, isTrue);
      expect(searchFocusNode.hasFocus, isFalse);

      await tester.pumpWidget(const SizedBox.shrink());
      searchFocusNode.dispose();
      otherFocusNode.dispose();
      searchController.dispose();
    },
  );
}
