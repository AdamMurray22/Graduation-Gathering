import 'package:flutter/material.dart';
import 'package:graduation_gathering/Screen/main_screen.dart';
import 'login_screen.dart';

/// This holds the screen for the application.
class ScreenHolder extends StatefulWidget {
  const ScreenHolder({super.key});

  @override
  State<ScreenHolder> createState() => _ScreenHolderState();
}

// This class contains the GUI structure for the app.
class _ScreenHolderState extends State<ScreenHolder> {

  late Widget _screen;

  @override
  initState() {
    _screen = LoginScreen(changeScreen: () {_switchToMainScreen();});
    super.initState();
  }

  /// Builds the GUI.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: _screen
    );
  }

  _switchToMainScreen()
  {
    setState(() {
      _screen = const MainScreen();
    });
  }
}