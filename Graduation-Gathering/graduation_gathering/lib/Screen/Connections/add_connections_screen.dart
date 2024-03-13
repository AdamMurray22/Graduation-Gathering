import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/get_connections.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/account_type.dart';
import '../../Profile/profile_settings.dart';

/// This holds the screen for the application.
class AddConnectionsScreen extends StatefulWidget {
  const AddConnectionsScreen(
      {super.key,
      required this.authToken,
      required this.connections,
      required this.backButtonPressed});

  final AuthToken authToken;
  final Connections connections;
  final Function() backButtonPressed;

  @override
  State<AddConnectionsScreen> createState() => _AddConnectionsScreenState();
}

// This class contains the GUI structure for the app.
class _AddConnectionsScreenState extends State<AddConnectionsScreen> {
  final SingleValueDropDownController _addConnectionsDropDownController =
      SingleValueDropDownController();
  final List<DropDownValueModel> _dropDownList = [];
  String? _selectedDropDownItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  widget.backButtonPressed();
                },
                child: const Text("Back", style: TextStyle(fontSize: 20))),
            DropDownTextField(
              key: const Key("Search box"),
              controller: _addConnectionsDropDownController,
              clearOption: true,
              enableSearch: true,
              textFieldDecoration: const InputDecoration(hintText: "Search"),
              searchDecoration:
                  const InputDecoration(hintText: "Search here"),
              validator: (value) {
                if (value == null) {
                  return "Required field";
                } else {
                  return null;
                }
              },
              dropDownItemCount: 5,
              dropDownList: _dropDownList,
              onChanged: (value) {
                if (value == "" || value == null) {
                  _selectedDropDownItem = null;
                } else {
                  _selectedDropDownItem = value.value;
                }
                setState(() {});
              },
            ),
            DropdownButton<String>(
                value: "Search By",
                items: const [
                  DropdownMenuItem(
                    value: "Search By",
                    child: Text("Search By"),
                  ),
                  DropdownMenuItem(
                    value: "Course",
                    child: Text("Course"),
                  ),
                  DropdownMenuItem(
                    value: "Email",
                    child: Text("Email"),
                  )
                ],
                menuMaxHeight: 500,
                onChanged: (value) {},
                elevation: 8,
                isExpanded: true,
                underline: Container())
          ],
        ));
  }
}
