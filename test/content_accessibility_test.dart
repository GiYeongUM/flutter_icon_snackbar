import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:icon_animated/icon_animated.dart';

void main() {
  testWidgets(
    'null callback disables taps and reduced motion shows content immediately',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: MediaQuery(
              data: const MediaQueryData(disableAnimations: true),
              child: const IconSnackBarContent(
                iconType: IconType.check,
                label: 'Saved',
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.widget<InkWell>(find.byType(InkWell)).onTap, isNull);
      expect(
        tester
            .widget<FadeTransition>(find.byType(FadeTransition).last)
            .opacity
            .value,
        1,
      );
      expect(tester.hasRunningAnimations, isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('status colors follow the active scheme', (tester) async {
    final colors = ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    );
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(colorScheme: colors),
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
      label: 'Failed',
      type: SnackBarType.fail,
    );
    await tester.pumpAndSettle();
    final content = tester.widget<IconSnackBarContent>(
      find.byType(IconSnackBarContent),
    );
    expect(content.backgroundColor, colors.errorContainer);
    expect(content.textStyle!.color, colors.onErrorContainer);
    controller.close();
    await tester.pumpAndSettle();
  });
}
