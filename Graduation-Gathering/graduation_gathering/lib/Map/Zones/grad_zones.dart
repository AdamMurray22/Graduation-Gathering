import 'package:graduation_gathering/Map/Zones/zone_colours_enum.dart';
import 'package:graduation_gathering/Sorts/heap_sort.dart';
import 'package:graduation_gathering/Sorts/comparator.dart';
import 'grad_zone.dart';

class GradZones extends Iterable<GradZone>
{
  final Set<GradZone> _gradZones = {};

  GradZones(List<dynamic> gradZones)
  {
    for (Map<String, dynamic> zone in gradZones)
    {
      _gradZones.add(GradZone(zone, ZoneColours.red.getColourRGB()));
    }
  }

  Set<GradZone> getZones()
  {
    return _gradZones;
  }

  List<GradZone> getZonesInOrder()
  {
    HeapSort<String> sort = HeapSort<String>(Comparator.alphabeticalComparator());
    List<String> sortedZoneIds = sort.sort(getIds());
    List<GradZone> zones = [];
    for (String zoneId in sortedZoneIds)
    {
      zones.add(getZoneFromId(zoneId)!);
    }
    return _gradZones.toList();
  }

  List<String> getIds()
  {
    List<String> ids = [];
    for (GradZone zone in this)
    {
      ids.add(zone.getId());
    }
    return ids;
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

  GradZone? getZoneFromId(String id)
  {
    for (GradZone zone in this)
    {
      if (zone.getId() == id)
      {
        return zone;
      }
    }
    return null;
  }

  @override
  Iterator<GradZone> get iterator => _gradZones.iterator;
}