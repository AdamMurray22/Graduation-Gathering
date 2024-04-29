import 'package:flutter/material.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/Connections/connection_profile.dart';
import '../../Profile/Connections/send_follow_request.dart';

/// Follow box widget.
class FollowBoxWidget extends StatefulWidget {
  const FollowBoxWidget({super.key, required this.profile, required this.token});

  final ConnectionProfile profile;
  final AuthToken token;

  @override
  State<FollowBoxWidget> createState() => _FollowBoxWidgetState();
}

// Follow box state.
class _FollowBoxWidgetState extends State<FollowBoxWidget> {
  late Widget _followWidget;

  @override
  void initState() {
    _followWidget = ElevatedButton(onPressed: () {
      _requestFollow();
      _followWidget = const Text("Request Sent");
      setState(() {
      });
    },
        child: const Text("Follow"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> followButtons = [];
    return Row(
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
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _followWidget,
      ])
    ],
    );
  }

  // Sends the follow request to the server.
  _requestFollow()
  {
    SendFollowRequest(widget.token).send(widget.profile);
  }
}
