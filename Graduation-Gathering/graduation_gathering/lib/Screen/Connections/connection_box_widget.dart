import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/get_connections.dart';
import 'package:graduation_gathering/Profile/Connections/grant_follower_request.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/Connections/connection_profile.dart';
import '../../Profile/Connections/other_user_profiles.dart';
import '../../Profile/Connections/remove_follower_request.dart';
import '../../Profile/Connections/remove_following_request.dart';
import '../../Profile/Connections/send_follow_request.dart';
import '../../Profile/account_type.dart';
import '../../Profile/profile_settings.dart';

/// This holds the screen for the application.
class ConnectionBoxWidget extends StatefulWidget {
  const ConnectionBoxWidget(
      {super.key, required this.profile, required this.token});

  final Connection profile;
  final AuthToken token;

  @override
  State<ConnectionBoxWidget> createState() => _ConnectionBoxWidgetState();
}

// This class contains the GUI structure for the app.
class _ConnectionBoxWidgetState extends State<ConnectionBoxWidget> {
  late Widget _followerWidget;
  late Widget _followingWidget;

  @override
  void initState() {
    _createButtons();
    super.initState();
  }

  _createButtons()
  {
    if (widget.profile.getPermissionFrom() == ConnectionPermission.requested) {
      _followerWidget = ElevatedButton(
          onPressed: () {
            grantFollower();
            _followerWidget = const Text("Permission Granted");
            setState(() {});
          },
          child: const Text("Grant Follower Permission"));
    } else if (widget.profile.getPermissionFrom() ==
        ConnectionPermission.granted) {
      _followerWidget = ElevatedButton(
          onPressed: () {
            removeFollower();
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
            removeFollowing();
            _followingWidget = ElevatedButton(
                onPressed: () {
                  sendFollowingRequest();
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
            removeFollowing();
            _followingWidget = ElevatedButton(
                onPressed: () {
                  sendFollowingRequest();
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
            sendFollowingRequest();
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

  sendFollowingRequest() {
    SendFollowRequest(widget.token).send(widget.profile.getConnectionProfile());
  }

  grantFollower() {
    GrantFollowerRequest(widget.token)
        .send(widget.profile.getConnectionProfile());
  }

  removeFollower() {
    RemoveFollowerRequest(widget.token)
        .send(widget.profile.getConnectionProfile());
  }

  removeFollowing() {
    RemoveFollowingRequest(widget.token)
        .send(widget.profile.getConnectionProfile());
  }
}
