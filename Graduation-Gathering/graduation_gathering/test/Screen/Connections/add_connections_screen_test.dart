import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/Connections/add_connections_screen.dart';

void main()
{
  testWidgets('Finds Filters Text', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddConnectionsScreen(
        authToken: AuthToken(""),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        academicStructure: AcademicStructure({}),
        backButtonPressed: () {},
        otherUserProfiles: OtherUserProfiles([]))));

    final topLineFinder = find.text('Filters: ');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Search Text Field', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddConnectionsScreen(
        authToken: AuthToken(""),
        connections: Connections([], OtherUserProfiles([]), ProfileSettings(true, "id" , "email", "student", null, null, null, null, GradZones([]))),
        academicStructure: AcademicStructure({}),
        backButtonPressed: () {},
        otherUserProfiles: OtherUserProfiles([]))));

    final topLineFinder = find.text('Enter a Name or Email address here...');

    expect(topLineFinder, findsOneWidget);
  });
}