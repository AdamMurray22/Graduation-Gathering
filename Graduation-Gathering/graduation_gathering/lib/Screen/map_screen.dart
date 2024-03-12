import 'package:flutter/material.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import '../Map/Zones/grad_zones.dart';
import '../Map/main_map_widget.dart';

/// The screen that displays the map.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.authToken, required this.allGradZones, required this.usersGradZones});

  final AuthToken authToken;
  final GradZones allGradZones;
  final GradZones usersGradZones;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

// The map screen state.
class _MapScreenState extends State<MapScreen> {
  late final MainMapWidget _mapWidget;

  @override
  initState() {
    _mapWidget = MainMapWidget(
      authToken: widget.authToken,
      allGradZones: widget.allGradZones,
      usersGradZones: widget.usersGradZones,
      markerClickedFunction: (String markerId) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0x1f000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
          ),
          child: _mapWidget),
    );
  }
}
