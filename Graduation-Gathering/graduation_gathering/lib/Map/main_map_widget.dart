import 'dart:convert';
import 'package:graduation_gathering/AWS/get_other_users_location.dart';
import 'package:graduation_gathering/AWS/graduation_dates.dart';
import 'package:graduation_gathering/AWS/send_location_data.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/colour.dart';
import 'package:graduation_gathering/Map/Zones/grad_zone.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:location/location.dart' as location_data;
import 'dart:async';

import '../Location/location_handler.dart';
import '../Location/location.dart';
import 'map_centre_enum.dart';
import 'map_data_id.dart';
import 'map_widget.dart';

/// The main map screen Widget.
class MainMapWidget extends MapWidget {
  const MainMapWidget({required this.authToken, required this.allGradZones, required this.usersGradZones, required this.graduationDates, super.markerClickedFunction, super.key});

  /// The auth token to authenticate requests to the server.
  final AuthToken authToken;
  /// All the graduation zones displayed on the map.
  final GradZones allGradZones;
  /// All of the zones that the user can appear in.
  final GradZones usersGradZones;
  /// The dates when location sharing is enabled.
  final GraduationDates graduationDates;

  @override
  MapWidgetState<MainMapWidget> createState() => MainMapWidgetState();
}

/// The main map screen state.
class MainMapWidgetState extends MapWidgetState<MainMapWidget> {

  late final SendLocationData _sendLocationData;
  late final GetOtherUsersLocation _getOtherUsersLocation;

  /// Sets the values for the map set up.
  @override
  void initState() {
    _sendLocationData = SendLocationData(widget.authToken);
    _getOtherUsersLocation = GetOtherUsersLocation(widget.authToken);
    onPageFinished = (url) async {
      setMapCentreZoom(MapCentreEnum.lat.value, MapCentreEnum.long.value,
          MapCentreEnum.initZoom.value);
      _addUserLocationIcon();
      _setUpGetOtherUsersLocations();
      _addGradZones();
    };
    super.initState();
  }

  // Assigns an id to each layer used by this map to be referenced later.
  @override
  createLayers() {
    createGeoJsonLayer(MapDataId.zones.idPrefix, Colour(0, 0, 255), 8);
    createMakerLayer(MapDataId.otherUsers.idPrefix, "test.png", 0.2, 0.5, 1, true);
    createMakerLayer(MapDataId.userLocation.idPrefix, "UserIcon.png", 0.1, 0.5, 0.5, false);
  }

  // Adds the users location to the map as a marker and sets for it be updated whenever the user moves.
  // Also sends the users location to the server when the user is within one of their chosen zones.
  _addUserLocationIcon() {
    LocationHandler handler = LocationHandler.getHandler();
    handler.onLocationChanged((location_data.LocationData currentLocation) async {
      updateMarker(MapDataId.userLocation.idPrefix, MapDataId.userLocation.idPrefix,
          currentLocation.longitude!, currentLocation.latitude!);
      if (!widget.graduationDates.isGraduationDayToday())
      {
        return;
      }
      if (await isPointInsideGeojson(currentLocation.longitude!, currentLocation.latitude!, widget.usersGradZones)) {
        _sendLocationData.send(
            Location(currentLocation.longitude!, currentLocation.latitude!));
      }
    });
  }

  // creates a repeating function to retrieve the other users locations.
  _setUpGetOtherUsersLocations() {
    const dur = Duration(seconds:10);
    Timer.periodic(dur, (Timer t) => _getOtherUsersLocations());
  }

  // Adds the other users markers to the map.
  _getOtherUsersLocations() async {
    if (!widget.graduationDates.isGraduationDayToday())
    {
      return;
    }
    _addOtherUsersMarkers(await _getOtherUsersLocation.send());
  }

  // Updates the other users markers by removing all markers that are not in the
  // list given, and checking that all the given markers are in the graduation zones.
  _addOtherUsersMarkers(List<dynamic> users) async {
    await clearMarkerLayer(MapDataId.otherUsers.idPrefix);
    for (Map<String, dynamic> user in users)
    {
      if (await isPointInsideGeojson(user["longitude"], user["latitude"], widget.allGradZones)) {
        updateMarker(MapDataId.otherUsers.idPrefix, user["email"],
            user["longitude"], user["latitude"]);
      }
    }
  }

  // Adds the zones to the map as geojsons.
  _addGradZones()
  {
    for (GradZone zone in widget.allGradZones) {
      addGeoJsonWithColour(MapDataId.zones.idPrefix, jsonEncode(zone.getGeoJson()), zone.getColour()!);
    }
  }

  /// Updates the zones colours.
  updateGradZoneColours()
  {
    clearGeoJsonLayer(MapDataId.zones.idPrefix);
    _addGradZones();
  }
}