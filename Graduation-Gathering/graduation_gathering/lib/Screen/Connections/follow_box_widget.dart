import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/get_connections.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/Connections/connection_profile.dart';
import '../../Profile/Connections/other_user_profiles.dart';
import '../../Profile/Connections/send_follow_request.dart';
import '../../Profile/account_type.dart';
import '../../Profile/profile_settings.dart';

/// This holds the screen for the application.
class FollowBoxWidget extends StatefulWidget {
  const FollowBoxWidget({super.key, required this.profile, required this.token});

  final ConnectionProfile profile;
  final AuthToken token;

  @override
  State<FollowBoxWidget> createState() => _FollowBoxWidgetState();
}

// This class contains the GUI structure for the app.
class _FollowBoxWidgetState extends State<FollowBoxWidget> {
  late Widget _followWidget;

  @override
  void initState() {
    _followWidget = ElevatedButton(onPressed: () {
      requestFollow();
      _followWidget = const Text("Request Sent");
      setState(() {
      });
    },
        child: const Text("Follow"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> followButtons = [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.profile.getMainText()),
            Text(widget.profile.getSubText()),
            Text(widget.profile.getAccountTypeString()),
          ],
        ),
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _followWidget,
      ])
    ],
    );
  }

  requestFollow()
  {
    SendFollowRequest(widget.token).send(widget.profile);
  }
}
