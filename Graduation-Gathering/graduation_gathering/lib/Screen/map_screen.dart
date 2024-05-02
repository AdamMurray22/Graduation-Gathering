import 'package:flutter/material.dart';
import 'package:graduation_gathering/AWS/graduation_dates.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/map_data_id.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import '../Map/Zones/grad_zones.dart';
import '../Map/main_map_widget.dart';
import '../Profile/Connections/connection_profile.dart';

/// The screen that displays the map.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.authToken, required this.allGradZones, required this.usersGradZones, required this.mainMapWidgetStateKey, this.mainMapWidget, required this.graduationDates, required this.otherUserProfiles});

  final AuthToken authToken;
  final GradZones allGradZones;
  final GradZones usersGradZones;
  final GraduationDates graduationDates;
  final OtherUserProfiles otherUserProfiles;
  final GlobalKey<MainMapWidgetState> mainMapWidgetStateKey;
  final MainMapWidget? mainMapWidget; // Used for Testing.

  @override
  State<MapScreen> createState() => _MapScreenState();
}

// The map screen state.
class _MapScreenState extends State<MapScreen> {
  late final MainMapWidget _mapWidget;

  final List<Widget> _featureTitleText = [];
  final List<Text> _featureInfoText = [];
  List<String> _featureTitleStrings = [];
  List<String> _infoStrings = [];
  bool _featureInfoVisible = false;

  @override
  initState() {
    if (widget.mainMapWidget == null) {
      _mapWidget = MainMapWidget(
        key: widget.mainMapWidgetStateKey,
        authToken: widget.authToken,
        allGradZones: widget.allGradZones,
        usersGradZones: widget.usersGradZones,
        otherUserProfiles: widget.otherUserProfiles,
        markerClickedFunction: (String markerId) {
          setState(() {_showMarkerInfo(markerId);});
        },
        graduationDates: widget.graduationDates
      );
    }
    else
    {
      _mapWidget = widget.mainMapWidget!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
          Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0x1f000000),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
                border:
                Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: _mapWidget),
          Visibility(
            visible: _featureInfoVisible, // not visible if set false
            child: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
                border:
                Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: ListView(
                children: [
                  ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      alignment: Alignment.topRight,
                      onPressed: () {
                        setState(() {
                          _featureInfoVisible = false;
                          _featureTitleText.clear();
                          _featureInfoText.clear();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children:
                          _featureTitleText
                        ),
                  ),
                ],
              ),
            ),
          ),
        ]),
    );
  }

  // Displays the info for the given marker as a bar at the top of the screen.
  _showMarkerInfo(String markerId)
  {
    MapDataId mapDataIdType = MapDataId.getMapDataIdEnumFromId(markerId);
    if (mapDataIdType == MapDataId.otherUsers)
    {
      _featureTitleText.clear();
      _featureInfoText.clear();
      _featureInfoVisible = true;
      ConnectionProfile? userProfile = widget.otherUserProfiles.getUserFromId(markerId);
      if (userProfile == null)
      {
        return;
      }
      _featureTitleStrings.clear();
      _featureTitleStrings.add(userProfile.getMainText());
      _featureTitleStrings.add(userProfile.getSubText());
      _featureTitleStrings.add(userProfile.getAccountTypeString());
      for (String info in _featureTitleStrings) {
        _featureTitleText.add(Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              info,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                color: Color(0xff000000),
              ),
            )));
      }
    }
  }
}
