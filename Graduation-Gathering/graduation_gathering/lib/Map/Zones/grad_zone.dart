import 'colour.dart';

/// A Graduation Zone for the purposes of the map.
class GradZone
{
  late final String _id;
  late final String _name;
  late final Map<String, dynamic> _geojson;
  Colour? _colour;

  GradZone(Map<String, dynamic> zone, this._colour)
  {
    _id = zone["id"];
    _name = zone["name"];
    _geojson = zone["geojson"];
  }

  /// Returns the zone as a geojson.
  Map<String, dynamic> getGeoJson()
  {
    return _geojson;
  }

  /// Returns the zone Id.
  String getId()
  {
    return _id;
  }

  /// Returns the zone name.
  String getName()
  {
    return _name;
  }

  /// Returns the zones Colour.
  Colour? getColour()
  {
    return _colour;
  }

  /// Sets the colour of the zone.
  setColour(Colour colour)
  {
    _colour = colour;
  }

  /// Sets the == operator to check if the id, name, colour and geojson are the same.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GradZone &&
              runtimeType == other.runtimeType &&
              getId() == other.getId() &&
              getName() == other.getName() &&
              getColour() == other.getColour();

  /// Sets the hashcode to use the id, name, colour and geojson.
  @override
  int get hashCode => _id.hashCode + _name.hashCode + _colour.hashCode;
}