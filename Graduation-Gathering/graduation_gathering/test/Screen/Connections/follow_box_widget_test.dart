import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Screen/Connections/follow_box_widget.dart';

void main()
{
  testWidgets('Finds Follow Button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FollowBoxWidget(
        profile: ConnectionProfile("id", "email", "student", null, null,null,null),
        token: AuthToken("")),));

    final topLineFinder = find.text('Follow');

    expect(topLineFinder, findsOneWidget);
  });
}