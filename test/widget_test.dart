import 'package:flutter_test/flutter_test.dart';
import 'package:geoclash/main.dart';

void main() {
  testWidgets('Geo Clash app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlagQuizApp());

    // Verify that the title is present.
    expect(find.text('GEO CLASH'), findsOneWidget);
    expect(find.text('START QUIZ'), findsOneWidget);
  });
}