import 'package:flutter/material.dart';
import 'package:graduation_gathering/Auth/token_storage.dart';
import 'package:graduation_gathering/Auth/validate_token.dart';
import 'package:graduation_gathering/Map/Zones/get_grad_zones.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:graduation_gathering/Screen/main_screen.dart';
import '../Auth/auth_token.dart';
import '../Login/get_user_profile.dart';
import '../Map/Zones/grad_zones.dart';
import '../Profile/academic_structure.dart';
import '../Profile/get_academic_structure.dart';
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
      await _loadMainScreen(authToken);
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
    await _loadMainScreen(authToken);
    setState(() {
    });
  }

  _loadMainScreen(AuthToken authToken) async
  {
    Future<AcademicStructure> futureStructure = GetAcademicStructure().send(authToken);
    GradZones zones = await GetGradZones().send(authToken);
    ProfileSettings profile = await GetUserProfile().send(authToken, zones);
    AcademicStructure structure = await futureStructure;
    _screen = MainScreen(authToken: authToken, profile: profile, academicStructure: structure, gradZones: zones, logoutFunction: _logout);
  }

  // Returns to the login screen and clears the token from the storage.
  _logout()
  {
    _tokenStorage.clearToken();
    _screen = LoginScreen(changeScreen: (authToken) {_switchToMainScreen(authToken);});
    setState(() {});
  }
}
