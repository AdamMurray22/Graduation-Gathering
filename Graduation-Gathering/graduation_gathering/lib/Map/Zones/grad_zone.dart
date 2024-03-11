class GradZone
{
  late final String _id;
  late final String _name;
  late final Map<String, dynamic> _geojson;

  GradZone(Map<String, dynamic> zone)
  {
    _id = zone["id"];
    _name = zone["name"];
    _geojson = zone["geojson"];
  }

  Map<String, dynamic> getGeoJson()
  {
    return _geojson;
  }
}