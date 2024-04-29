/// Defines the lat, long and zoom for when the map initially loads.
enum MapCentreEnum
{
  /// Start latitude.
  lat(50.7958),
  /// Start Longitude.
  long(-1.0960),
  /// Start Zoom.
  initZoom(17),
  /// Zoom when a marker is clicked.
  markerClickedZoom(19);

  const MapCentreEnum(this.value);
  final double value;
}