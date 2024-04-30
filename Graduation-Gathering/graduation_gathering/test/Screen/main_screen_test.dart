import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/AWS/graduation_dates.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Map/main_map_widget.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/about_screen.dart';
import 'package:graduation_gathering/Screen/main_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_screen_test.mocks.dart';

@GenerateMocks([MainMapWidget])
void main()
{
  testWidgets('Finds Title', (tester) async {
    final mockMapWidget = MockMainMapWidget();

    const container = AboutScreen();

    when(mockMapWidget.key).thenAnswer((realInvocation) => container.key);
    when(mockMapWidget.createElement()).thenAnswer((realInvocation) => container.createElement());

    await tester.pumpWidget(MaterialApp(home: MainScreen(
      authToken: AuthToken(""),
      profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
      academicStructure: AcademicStructure({}), gradZones: GradZones([]),
      connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
      otherUserProfiles: OtherUserProfiles([]),
      mainMapWidget: mockMapWidget, logoutFunction: () {  }, graduationDates: GraduationDates([]),)));

    final titleFinder = find.text('Graduation Gathering');

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Finds Bottom Nav Bar Home', (tester) async {
    final mockMapWidget = MockMainMapWidget();

    const container = AboutScreen();

    when(mockMapWidget.key).thenAnswer((realInvocation) => container.key);
    when(mockMapWidget.createElement()).thenAnswer((realInvocation) => container.createElement());

    await tester.pumpWidget(MaterialApp(home: MainScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), gradZones: GradZones([]),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        mainMapWidget: mockMapWidget, logoutFunction: () {  }, graduationDates: GraduationDates([]),)));
    final navBarFinder = find.text("Home");

    expect(navBarFinder, findsOneWidget);
  });

  testWidgets('Finds Bottom Nav Bar Connections', (tester) async {
    final mockMapWidget = MockMainMapWidget();

    const container = AboutScreen();

    when(mockMapWidget.key).thenAnswer((realInvocation) => container.key);
    when(mockMapWidget.createElement()).thenAnswer((realInvocation) => container.createElement());

    await tester.pumpWidget(MaterialApp(home: MainScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), gradZones: GradZones([]),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        mainMapWidget: mockMapWidget, logoutFunction: () {  }, graduationDates: GraduationDates([]),)));
    final navBarFinder = find.byIcon(Icons.person);

    expect(navBarFinder, findsOneWidget);
  });

  testWidgets('Finds Bottom Nav Bar Profile', (tester) async {
    final mockMapWidget = MockMainMapWidget();

    const container = AboutScreen();

    when(mockMapWidget.key).thenAnswer((realInvocation) => container.key);
    when(mockMapWidget.createElement()).thenAnswer((realInvocation) => container.createElement());

    await tester.pumpWidget(MaterialApp(home: MainScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), gradZones: GradZones([]),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        mainMapWidget: mockMapWidget, logoutFunction: () {  }, graduationDates: GraduationDates([]),)));
    final navBarFinder = find.text("Profile");

    expect(navBarFinder, findsOneWidget);
  });

  testWidgets('Finds Bottom Nav Bar About', (tester) async {
    final mockMapWidget = MockMainMapWidget();

    const container = AboutScreen();

    when(mockMapWidget.key).thenAnswer((realInvocation) => container.key);
    when(mockMapWidget.createElement()).thenAnswer((realInvocation) => container.createElement());

    await tester.pumpWidget(MaterialApp(home: MainScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), gradZones: GradZones([]),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        mainMapWidget: mockMapWidget, logoutFunction: () {  }, graduationDates: GraduationDates([]),)));
    final navBarFinder = find.text("About");

    expect(navBarFinder, findsOneWidget);
  });

  testWidgets('Taps Nav Bar Profile', (tester) async {
    final mockMapWidget = MockMainMapWidget();

    const container = AboutScreen();

    when(mockMapWidget.key).thenAnswer((realInvocation) => container.key);
    when(mockMapWidget.createElement()).thenAnswer((realInvocation) => container.createElement());

    await tester.pumpWidget(MaterialApp(home: MainScreen(
        authToken: AuthToken(""),
        profile: ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([])),
        academicStructure: AcademicStructure({}), gradZones: GradZones([]),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        mainMapWidget: mockMapWidget, logoutFunction: () {  }, graduationDates: GraduationDates([]),)));
    final navBarFinder = find.text("Profile");
    await tester.tap(navBarFinder);
    await tester.pump();

    expect(find.text("Save"), findsOneWidget);
  });
}