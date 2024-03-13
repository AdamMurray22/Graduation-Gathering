import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/get_connections.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../Auth/auth_token.dart';
import '../Profile/account_type.dart';
import '../Profile/profile_settings.dart';

/// This holds the screen for the application.
class ManageUserPermissionsScreen extends StatefulWidget {
  const ManageUserPermissionsScreen(
      {super.key,
      required this.authToken, required this.connections});

  final AuthToken authToken;
  final Connections connections;

  @override
  State<ManageUserPermissionsScreen> createState() =>
      _ManageUserPermissionsScreenState();
}

// This class contains the GUI structure for the app.
class _ManageUserPermissionsScreenState extends State<ManageUserPermissionsScreen> {

  late Widget _connectionsContainer;

  @override
  void initState() {
    createConnectionsContainer();
    super.initState();
  }

  createConnectionsContainer()
  {
    if (widget.connections.isEmpty) {
      _connectionsContainer = const Text("You have no Connections");
    }
    else
    {
      List<Widget> connectionsWidgets = [];
      for (Connection connection in widget.connections)
      {
        connectionsWidgets.add(Text(connection.getToUserId()));
      }
      _connectionsContainer = Column(
        children: connectionsWidgets,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        onPressed: () {refreshPressed();}, child: const Text("Refresh")),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Add Connections")),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: false,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xFFD3D3D3),
                      child: const Text("Location Requests", style: TextStyle(fontSize: 17)),
                    ),

                  ],
                ),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xFFD3D3D3),
                  child: const Text("Connections", style: TextStyle(fontSize: 17)),
                ),
                _connectionsContainer
              ],
            ),
          ],
        ));
  }

  refreshPressed() async
  {
    Connections connections = await GetConnections().send(widget.authToken);
    widget.connections.clear();
    widget.connections.addAll(connections);
    createConnectionsContainer();
    setState(() {
    });
  }
}
