import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/Connections/connections_screen.dart';

void main()
{
  testWidgets('Finds No Connections Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionsScreen(
      authToken: AuthToken(""),
      connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([]))),
      otherUserProfiles: OtherUserProfiles([]),
      academicStructure: AcademicStructure({}),
      userProfile: ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([])))));

    final topLineFinder = find.text('You have no Connections');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Refresh Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionsScreen(
        authToken: AuthToken(""),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        academicStructure: AcademicStructure({}),
        userProfile: ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([])))));

    final topLineFinder = find.text('Refresh');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Add Connections Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionsScreen(
        authToken: AuthToken(""),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        academicStructure: AcademicStructure({}),
        userProfile: ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([])))));

    final topLineFinder = find.text('Add Connections');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Connections Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionsScreen(
        authToken: AuthToken(""),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([]))),
        otherUserProfiles: OtherUserProfiles([]),
        academicStructure: AcademicStructure({}),
        userProfile: ProfileSettings(true, "id", "email", "Student", null, null, null,null, GradZones([])))));

    final topLineFinder = find.text('Connections');

    expect(topLineFinder, findsOneWidget);
  });
}