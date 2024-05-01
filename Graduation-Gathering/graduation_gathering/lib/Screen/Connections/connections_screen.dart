import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/get_connections.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Screen/Connections/add_connections_screen.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/Connections/connection_permission_enum.dart';
import '../../Profile/Connections/other_user_profiles.dart';
import '../../Profile/profile_settings.dart';
import 'connection_box_widget.dart';

/// Connection screen widget.
class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen(
      {super.key,
      required this.authToken,
      required this.connections,
      required this.otherUserProfiles, required this.academicStructure, required this.userProfile});

  final AuthToken authToken;
  final Connections connections;
  final OtherUserProfiles otherUserProfiles;
  final AcademicStructure academicStructure;
  final ProfileSettings userProfile;

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

// Connection screen state.
class _ConnectionsScreenState extends State<ConnectionsScreen> {
  late Widget _connectionsContainer;
  late Widget _connectionRequestsContainer;
  bool connectionRequests = false;

  int _screenIndex = 0;

  @override
  void initState() {
    _createConnectionsContainer();
    super.initState();
  }

  // Creates the visual list of connections
  _createConnectionsContainer() {
    List<Connection> connections = [];
    List<Connection> connectionsToRequested = [];
    for (Connection connection in widget.connections) {
      if (!(connection.getPermissionFrom() == ConnectionPermission.requested))
      {
        connections.add(connection);
      }
      else
      {
        connectionsToRequested.add(connection);
      }
    }

    if (connections.isEmpty) {
      _connectionsContainer = const Text("You have no Connections");
    } else {
      List<Widget> connectionsWidgets = [];
      for (Connection connection in connections) {
        connectionsWidgets.add(ConnectionBoxWidget(profile: connection, token: widget.authToken));
      }
      _connectionsContainer = Column(
        children: connectionsWidgets,
      );
    }

    if (connectionsToRequested.isEmpty) {
      _connectionRequestsContainer = const Text("You have no Connection Requests");
      connectionRequests = false;
    } else {
      connectionRequests = true;
      List<Widget> connectionsToRequestedWidgets = [];
      for (Connection connection in connectionsToRequested) {
        connectionsToRequestedWidgets.add(ConnectionBoxWidget(profile: connection, token: widget.authToken));
      }
      _connectionRequestsContainer = Column(
        children: connectionsToRequestedWidgets,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        resizeToAvoidBottomInset: false,
        body: IndexedStack(index: _screenIndex, children: [
          Column(
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
                          onPressed: () {
                            _refreshPressed();
                          },
                          child: const Text("Refresh")),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            _screenIndex = 1;
                            setState(() {});
                          },
                          child: const Text("Add Connections")),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: connectionRequests,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xFFD3D3D3),
                      child: const Text("Location Requests",
                          style: TextStyle(fontSize: 17)),
                    ),
                    _connectionRequestsContainer
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFFD3D3D3),
                    child: const Text("Connections",
                        style: TextStyle(fontSize: 17)),
                  ),
                  _connectionsContainer
                ],
              ),
            ],
          ),
          AddConnectionsScreen(
              authToken: widget.authToken,
              connections: widget.connections,
              otherUserProfiles: widget.otherUserProfiles,
              academicStructure: widget.academicStructure,
              backButtonPressed: () {
                _screenIndex = 0;
                setState(() {});
              }),
        ]));
  }

  // Retrieves the updated connections from the server and updates the display.
  _refreshPressed() async {
    Connections connections = await GetConnections().send(widget.authToken, widget.otherUserProfiles, widget.userProfile);
    widget.connections.clear();
    widget.connections.addAll(connections);
    _createConnectionsContainer();
    setState(() {});
  }
}
