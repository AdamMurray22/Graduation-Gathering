import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/profile_screen.dart';

void main()
{
  testWidgets('Finds Profile Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen(
      authToken: AuthToken(""),
      profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
      academicStructure: AcademicStructure({}), allGradZones: GradZones([]),
      mainMapWidgetStateKey: GlobalKey(), logoutFunction: () {  },)));

    final topLineFinder = find.text('Profile');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Name Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), allGradZones: GradZones([]),
        mainMapWidgetStateKey: GlobalKey(), logoutFunction: () {  },)));

    final topLineFinder = find.text('Name: ');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Account Type Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), allGradZones: GradZones([]),
        mainMapWidgetStateKey: GlobalKey(), logoutFunction: () {  },)));

    final topLineFinder = find.text('Account Type: Student');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Name Text Field', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), allGradZones: GradZones([]),
        mainMapWidgetStateKey: GlobalKey(), logoutFunction: () {  },)));

    final topLineFinder = find.text('Enter your name here...');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Graduation Zones Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), allGradZones: GradZones([]),
        mainMapWidgetStateKey: GlobalKey(), logoutFunction: () {  },)));

    final topLineFinder = find.text('Graduation Zones you can be seen in:');

    expect(topLineFinder, findsOneWidget);
  });
}