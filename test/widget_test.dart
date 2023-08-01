// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/reusable_widget/vux/buttom/template.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    /// Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    /// Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    /// Tap the '+' icon and trigger a frame.
    Finder finder = find.byKey(Key('template_button'));
    await tester.longPress(finder);
    await tester.pumpAndSettle(Duration(milliseconds: 200));

    final scaleValue = tester.widget<ScaleTransition>(
      find.descendant(
        of: finder,
        matching: find.byType(ScaleTransition),
      ),
    ).scale.value;

    print(scaleValue);

    await tester.tap(finder);
    await tester.pump();
    /// Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
    
    expect(scaleValue, isNot(equals(1.0)));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Template Button Example')),
        body: Center(
          child: Template(
            key: Key('template_button'),
          ),
        ),
      ),
    );
  }
}
