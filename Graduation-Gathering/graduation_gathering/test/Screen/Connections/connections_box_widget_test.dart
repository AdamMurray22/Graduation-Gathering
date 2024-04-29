import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Screen/Connections/connection_box_widget.dart';

void main()
{
  testWidgets('Finds Grant Follower Permission Button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionBoxWidget(
        profile: Connection(ConnectionProfile("id", "email", "student", null, null,null,null), null, ConnectionPermission.requested),
        token: AuthToken("")),));

    final topLineFinder = find.text('Grant Follower Permission');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Request Following Permission Button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionBoxWidget(
        profile: Connection(ConnectionProfile("id", "email", "student", null, null,null,null), null, ConnectionPermission.requested),
        token: AuthToken("")),));

    final topLineFinder = find.text('Request Following permission');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Remove Follower Permission Permission Button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionBoxWidget(
        profile: Connection(ConnectionProfile("id", "email", "student", null, null,null,null), null, ConnectionPermission.granted),
        token: AuthToken("")),));

    final topLineFinder = find.text('Remove Follower Permission');

    expect(topLineFinder, findsOneWidget);
  });

  testWidgets('Finds Remove Following Request Permission Button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ConnectionBoxWidget(
        profile: Connection(ConnectionProfile("id", "email", "student", null, null,null,null), ConnectionPermission.requested, ConnectionPermission.granted),
        token: AuthToken("")),));

    final topLineFinder = find.text('Remove Following request');

    expect(topLineFinder, findsOneWidget);
  });
}