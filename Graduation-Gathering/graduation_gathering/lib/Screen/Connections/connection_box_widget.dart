import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/grant_follower_request.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/Connections/remove_follower_request.dart';
import '../../Profile/Connections/remove_following_request.dart';
import '../../Profile/Connections/send_follow_request.dart';

/// Connection box widget.
class ConnectionBoxWidget extends StatefulWidget {
  const ConnectionBoxWidget(
      {super.key, required this.profile, required this.token});

  final Connection profile;
  final AuthToken token;

  @override
  State<ConnectionBoxWidget> createState() => _ConnectionBoxWidgetState();
}

// Connection box state.
class _ConnectionBoxWidgetState extends State<ConnectionBoxWidget> {
  late Widget _followerWidget;
  late Widget _followingWidget;

  @override
  void initState() {
    _createButtons();
    super.initState();
  }

  // Takes the permissions between the client user and the user this box is about
  // and creates the buttons to manage the permissions.
  _createButtons()
  {
    if (widget.profile.getPermissionFrom() == ConnectionPermission.requested) {
      _followerWidget = ElevatedButton(
          onPressed: () {
            _grantFollower();
            _followerWidget = const Text("Permission Granted");
            setState(() {});
          },
          child: const Text("Grant Follower Permission"));
    } else if (widget.profile.getPermissionFrom() ==
        ConnectionPermission.granted) {
      _followerWidget = ElevatedButton(
          onPressed: () {
            _removeFollower();
            _followerWidget = const Text("Permission Removed");
            setState(() {});
          },
          child: const Text("Remove Follower Permission"));
    } else {
      _followerWidget = Container();
    }

    if (widget.profile.getPermissionTo() == ConnectionPermission.requested) {
      _followingWidget = ElevatedButton(
          onPressed: () {
            _removeFollowing();
            _followingWidget = ElevatedButton(
                onPressed: () {
                  _sendFollowingRequest();
                  _followingWidget = const Text("Request sent");
                  setState(() {});
                },
                child: const Text("Request Following permission"));
            setState(() {});
          },
          child: const Text("Remove Following request"));
    } else if (widget.profile.getPermissionTo() ==
        ConnectionPermission.granted) {
      _followingWidget = ElevatedButton(
          onPressed: () {
            _removeFollowing();
            _followingWidget = ElevatedButton(
                onPressed: () {
                  _sendFollowingRequest();
                  _followingWidget = const Text("Request sent");
                  setState(() {});
                },
                child: const Text("Request Following permission"));
            setState(() {});
          },
          child: const Text("Remove Following"));
    } else if (widget.profile.getPermissionTo() ==
        ConnectionPermission.denied) {
      _followingWidget = Container();
    } else {
      _followingWidget = ElevatedButton(
          onPressed: () {
            _sendFollowingRequest();
            _followingWidget = const Text("Request sent");
            setState(() {});
          },
          child: const Text("Request Following permission"));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> followButtons = [_followerWidget, _followingWidget];

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.profile.getMainText()),
                Text(widget.profile.getSubText()),
                Text(widget.profile.getAccountTypeString()),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: followButtons)
          ],
        ));
  }

  // Sends a follow request to the server.
  _sendFollowingRequest() {
    SendFollowRequest(widget.token).send(widget.profile.getConnectionProfile());
  }

  // Grants a follower on the server.
  _grantFollower() {
    GrantFollowerRequest(widget.token)
        .send(widget.profile.getConnectionProfile());
  }

  // Removes a follow from the server.
  _removeFollower() {
    RemoveFollowerRequest(widget.token)
        .send(widget.profile.getConnectionProfile());
  }

  // Removes the following request from the server.
  _removeFollowing() {
    RemoveFollowingRequest(widget.token)
        .send(widget.profile.getConnectionProfile());
  }
}
