import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../Auth/auth_token.dart';
import '../Profile/account_type.dart';
import '../Profile/profile_settings.dart';

/// This holds the screen for the application.
class ManageUserPermissionsScreen extends StatefulWidget {
  const ManageUserPermissionsScreen(
      {super.key, required this.authToken, required this.profile, required this.academicStructure});

  final AuthToken authToken;
  final ProfileSettings profile;
  final AcademicStructure academicStructure;

  @override
  State<ManageUserPermissionsScreen> createState() => _ManageUserPermissionsScreenState();
}

// This class contains the GUI structure for the app.
class _ManageUserPermissionsScreenState extends State<ManageUserPermissionsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        );
  }
}
