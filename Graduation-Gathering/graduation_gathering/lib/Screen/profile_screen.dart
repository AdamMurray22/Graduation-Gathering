import 'package:flutter/material.dart';

import '../Map/main_map_widget.dart';

/// This holds the screen for the application.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// This class contains the GUI structure for the app.
class _ProfileScreenState extends State<ProfileScreen> {
  late final MainMapWidget _mapWidget;

  @override
  initState() {
    _mapWidget = MainMapWidget(
      markerClickedFunction: (String markerId) {
        setState(() {});
      },
    );
    super.initState();
  }

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