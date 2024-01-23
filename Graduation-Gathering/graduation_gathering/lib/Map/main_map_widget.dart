import 'map_centre_enum.dart';
import 'map_widget.dart';

class MainMapWidget extends MapWidget {
  const MainMapWidget({super.markerClickedFunction, super.pingTileServerFunction, super.key});

  @override
  MapWidgetState<MainMapWidget> createState() => MainMapWidgetState();
}

/// The main map screen state.
class MainMapWidgetState extends MapWidgetState<MainMapWidget> {

  /// Sets the values for the map set up.
  @override
  void initState() {
    onPageFinished = (url) async {
      setMapCentreZoom(MapCentreEnum.lat.value, MapCentreEnum.long.value,
          MapCentreEnum.initZoom.value);
    };
    super.initState();
  }

  // Assigns an id to each layer used by this map to be referenced later.
  @override
  createLayers() {

  }
}