import 'package:flutter/material.dart';
import '../Map/main_map_widget.dart';

/// The screen that displays the map.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

// The map screen state.
class _MapScreenState extends State<MapScreen> {
  late final MainMapWidget _mapWidget;

  @override
  initState() {
    _mapWidget = MainMapWidget(
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
