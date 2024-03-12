import 'grad_zone.dart';

class GradZones extends Iterable<GradZone>
{
  final Set<GradZone> _gradZones = {};

  GradZones(List<dynamic> gradZones)
  {
    for (Map<String, dynamic> zone in gradZones)
    {
      _gradZones.add(GradZone(zone));
    }
  }

  Set<GradZone> getZones()
  {
    return _gradZones;
  }

  addZone(GradZone zone)
  {
    _gradZones.add(zone);
  }

  removeZone(GradZone zone)
  {
    _gradZones.remove(zone);
  }

  List<Map<String, dynamic>> geojsonsAsList()
  {
    List<Map<String, dynamic>> zones = [];
    for (GradZone zone in this)
    {
      zones.add(zone.getGeoJson());
    }
    return zones;
  }

  @override
  Iterator<GradZone> get iterator => _gradZones.iterator;
}