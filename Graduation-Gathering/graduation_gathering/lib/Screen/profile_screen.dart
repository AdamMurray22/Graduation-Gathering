import 'package:flutter/material.dart';

import '../Auth/auth_token.dart';
import '../Map/main_map_widget.dart';
import '../Profile/profile_settings.dart';

/// This holds the screen for the application.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.authToken, required this.profile});

  final AuthToken authToken;
  final ProfileSettings profile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// This class contains the GUI structure for the app.
class _ProfileScreenState extends State<ProfileScreen> {
  String _email = "";
  String _accountType = "";
  String? _name = "";

  @override void initState() {
    _email = widget.profile.getEmail();
    _accountType = widget.profile.getAccountType();
    _name = widget.profile.getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
        
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              const Text("Profile", style: TextStyle(fontSize: 30)),
              const SizedBox(height: 5),
              Text("Email: $_email", style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              Text("Account Type: $_accountType",
                  style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              const Text("Name: ", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              const Text("Faculty:", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              const Text("School:", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              const Text("Course: ", style: TextStyle(fontSize: 22)),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save", style: TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        )));
  }
}
