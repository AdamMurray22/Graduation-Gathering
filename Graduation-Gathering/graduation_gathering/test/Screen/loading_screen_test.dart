import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Screen/loading_screen.dart';

void main()
{
  testWidgets('Finds Loading Text', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoadingScreen()));
    final topLineFinder = find.text('Loading...');

    expect(topLineFinder, findsOneWidget);
  });
}