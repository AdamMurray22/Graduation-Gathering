import 'package:flutter/material.dart';

import '../Auth/auth_token.dart';
import '../Map/main_map_widget.dart';

/// This holds the screen for the application.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.authToken});

  final AuthToken authToken;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// This class contains the GUI structure for the app.
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0x1f000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
          ),
          child: Text("Hi")),
    );
  }
}