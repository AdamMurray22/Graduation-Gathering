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
import '../../Profile/account_type.dart';
import '../../Profile/profile_settings.dart';

/// This holds the screen for the application.
class ConnectionBoxWidget extends StatefulWidget {
  const ConnectionBoxWidget(
      {super.key, required this.profile});

  final ConnectionProfile profile;

  @override
  State<ConnectionBoxWidget> createState() => _ConnectionBoxWidgetState();
}

// This class contains the GUI structure for the app.
class _ConnectionBoxWidgetState extends State<ConnectionBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Text(widget.profile.getEmail()));
  }
}
