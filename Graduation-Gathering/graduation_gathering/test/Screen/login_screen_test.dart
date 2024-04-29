import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Screen/login_screen.dart';

void main()
{
  testWidgets('Finds Enter Email Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen(changeScreen: (token) {})));
    final topLineFinder = find.text('Please enter your University email:');
    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Enter Email Text Field', (tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen(changeScreen: (token) {})));
    final topLineFinder = find.text('Email...');
    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Taps Enter Email Button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen(changeScreen: (token) {})));
    final topLineFinder = find.byIcon(Icons.arrow_outward);
    await tester.tap(topLineFinder);
    await tester.pump();

    expect(find.text('Must be a valid University of Portsmouth email'), findsOneWidget);
  });
}