import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';

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
  late SetUserProfile _setUserProfile;

  String _email = "";
  String _accountType = "";
  String? _name;

  @override void initState() {
    _setUserProfile = SetUserProfile(widget.authToken);
    _email = widget.profile.getEmail();
    _accountType = widget.profile.getAccountType();
    _name = widget.profile.getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    if (_name != null) {
      textEditingController.text = _name!;
    }
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
              Row(
                  children: [
                    const Text("Name: ", style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 3),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child:TextField(
                      onChanged: (text) {
                        if (text.length > 50)
                        {
                          text = text.substring(0, 50);
                        }
                        _name = text;
                      },
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 0.0),
                        ),
                        hintText: 'Enter your name here...',
                      ),
                    )),
                  ]),
              const SizedBox(height: 5),
              const Text("Faculty:", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              const Text("School:", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              const Text("Course: ", style: TextStyle(fontSize: 22)),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {_saveSettings();},
                  child: const Text("Save", style: TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        )));
  }

  _saveSettings()
  {
    widget.profile.setHasLoggedInBefore(true);
    widget.profile.setName(_name);
    //widget.profile.setFaculty(faculty);
    //widget.profile.setSchool(school);
    //widget.profile.setCourse(course);
    _setUserProfile.send(widget.profile);
  }
}
