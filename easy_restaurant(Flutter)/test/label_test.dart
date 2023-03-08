import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'app_test.dart';

void main() {
  testWidgets('InfoLabel labelStyle is applied correctly to Text',
      (WidgetTester tester) async {
    const labelStyle = TextStyle();

    await tester.pumpWidget(
      wrapApp(
        child: const InfoLabel(
          label: 'Label text',
          labelStyle: labelStyle,
        ),
      ),
    );

    expect(tester.widget<Text>(find.text('Label text')).style, labelStyle);
  });
}
