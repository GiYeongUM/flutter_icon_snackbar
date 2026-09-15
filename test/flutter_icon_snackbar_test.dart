import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_animated/icon_animated.dart';

void main() {
  testWidgets(
    'maps statuses, shows labels, and closes through the controller',
    (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (value) {
              context = value;
              return const Scaffold();
            },
          ),
        ),
      );
      final icons = [IconType.check, IconType.fail, IconType.alert];
      for (final type in SnackBarType.values) {
        final controller = showIconSnackBar(
          context,
          label: type.name,
          type: type,
          duration: const Duration(minutes: 1),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pumpAndSettle();
        expect(find.text(type.name), findsOneWidget);
        expect(
          tester.widget<IconAnimated>(find.byType(IconAnimated)).iconType,
          icons[type.index],
        );
        controller.close();
        await tester.pumpAndSettle();
        expect(await controller.closed, SnackBarClosedReason.hide);
      }
    },
  );

  testWidgets('tap dismisses the snack bar', (tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (value) {
            context = value;
            return const Scaffold();
          },
        ),
      ),
    );
    final controller = showIconSnackBar(
      context,
      label: 'Saved',
      type: SnackBarType.success,
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Saved'));
    await tester.pumpAndSettle();
    expect(await controller.closed, SnackBarClosedReason.remove);
  });

  testWidgets('disposal safely stops the entrance animation', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IconSnackBarContent(
            iconType: IconType.check,
            label: 'Saved',
            onPressed: () {},
          ),
        ),
      ),
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets(
    'preserves default text color with a partial style and supports RTL',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: IconSnackBarContent(
                iconType: IconType.check,
                label: 'Saved',
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      final text = tester.widget<Text>(find.text('Saved'));
      expect(
        text.style!.color,
        Theme.of(
          tester.element(find.text('Saved')),
        ).colorScheme.onInverseSurface,
      );
      expect(text.style!.fontWeight, FontWeight.bold);
      expect(tester.takeException(), isNull);
    },
  );
}
