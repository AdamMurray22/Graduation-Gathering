import 'dart:convert';

import 'package:graduation_gathering/AWS/get_other_users_location.dart';
import 'package:graduation_gathering/AWS/send_location_data.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zone.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:location/location.dart' as location_data;
import 'dart:async';

import '../Location/location_handler.dart';
import '../Location/location.dart';
import 'map_centre_enum.dart';
import 'map_data_id.dart';
import 'map_widget.dart';

class MainMapWidget extends MapWidget {
  const MainMapWidget({required this.authToken, required this.gradZones, super.markerClickedFunction, super.key});

  final AuthToken authToken;
  final GradZones gradZones;

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
    createMakerLayer(MapDataId.userLocation.idPrefix, "UserIcon.png", 0.1, 0.5, 0.5, false);
    createMakerLayer(MapDataId.otherUsers.idPrefix, "test.png", 0.2, 0.5, 1, true);
    createGeoJsonLayer(MapDataId.zones.idPrefix, "blue", 8);
  }

  /// Adds the users location to the map as a marker and sets for it be updated
  /// whenever the user moves.
  _addUserLocationIcon() {
    LocationHandler handler =
    LocationHandler.getHandler();
    handler.onLocationChanged((location_data.LocationData currentLocation) {
      updateMarker(MapDataId.userLocation.idPrefix, MapDataId.userLocation.idPrefix,
          currentLocation.longitude!, currentLocation.latitude!);
      _sendLocationData.send(Location(currentLocation.longitude!, currentLocation.latitude!));
    });
  }

  _setUpGetOtherUsersLocations() {
    const dur = Duration(seconds:10);
    Timer.periodic(dur, (Timer t) => _getOtherUsersLocations());
  }

  _getOtherUsersLocations() async {
    _addOtherUsersMarkers(await _getOtherUsersLocation.send());
  }

  _addOtherUsersMarkers(List<dynamic> users)
  {
    for (Map<String, dynamic> user in users)
    {
      updateMarker(MapDataId.otherUsers.idPrefix, user["email"],
          user["location"]["long"], user["location"]["lat"]);
    }
  }

  _addGradZones()
  {
    for (GradZone zone in widget.gradZones) {
      addGeoJson(MapDataId.zones.idPrefix, jsonEncode(zone.getGeoJson()));
    }
  }
}