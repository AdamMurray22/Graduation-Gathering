import 'package:flutter/material.dart';
import 'package:graduation_gathering/Auth/token_storage.dart';
import 'package:graduation_gathering/Auth/validate_token.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/main_screen.dart';
import '../Auth/auth_token.dart';
import '../Login/get_user_profile.dart';
import 'loading_screen.dart';
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

  final TokenStorage _tokenStorage = TokenStorage();

  @override
  initState() {
    _screen = const LoadingScreen();
    validateToken();
    super.initState();
  }

  validateToken() async {
    AuthToken? authToken = await _tokenStorage.getToken();
    if (!(await ValidateToken().valid(authToken)))
    {
      authToken = null;
    }
    if (authToken != null) {
      ProfileSettings profile = await GetUserProfile().send(authToken);
      _screen = MainScreen(authToken: authToken, profile: profile);
    }
    else
    {
      _screen = LoginScreen(changeScreen: (authToken) {_switchToMainScreen(authToken);});
    }
    setState(() {});
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

  _switchToMainScreen(AuthToken authToken) async
  {
    _tokenStorage.writeToken(authToken);
    ProfileSettings profile = await GetUserProfile().send(authToken);
    _screen = MainScreen(authToken: authToken, profile: profile);
    setState(() {
    });
  }
}
