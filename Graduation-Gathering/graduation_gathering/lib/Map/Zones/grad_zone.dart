import 'colour.dart';

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

  Map<String, dynamic> getGeoJson()
  {
    return _geojson;
  }

  String getId()
  {
    return _id;
  }

  String getName()
  {
    return _name;
  }

  Colour? getColour()
  {
    return _colour;
  }

  setColour(Colour colour)
  {
    _colour = colour;
  }
}