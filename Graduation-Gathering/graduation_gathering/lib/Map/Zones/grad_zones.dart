import 'package:graduation_gathering/Map/Zones/zone_colours_enum.dart';
import 'package:graduation_gathering/Sorts/heap_sort.dart';
import 'package:graduation_gathering/Sorts/comparator.dart';
import 'grad_zone.dart';

/// The graduation zones.
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

  GradZones.preformedZones(List<GradZone> zones)
  {
    _gradZones.addAll(zones);
  }

  /// Returns the zones as a set.
  Set<GradZone> getZones()
  {
    return _gradZones;
  }

  /// Returns the zones as a list sorted in alphabetical order of their ids.
  List<GradZone> getZonesInOrder()
  {
    HeapSort<String> sort = HeapSort<String>(Comparator.alphabeticalComparator());
    List<String> sortedZoneIds = sort.sort(getIds());
    List<GradZone> zones = [];
    for (String zoneId in sortedZoneIds)
    {
      zones.add(getZoneFromId(zoneId)!);
    }
    return zones;
  }

  /// Returns the Id's for the zones as a list.
  Set<String> getIds()
  {
    Set<String> ids = {};
    for (GradZone zone in this)
    {
      ids.add(zone.getId());
    }
    return ids;
  }

  /// Adds a zone to the collection.
  addZone(GradZone zone)
  {
    _gradZones.add(zone);
  }

  /// Removes the given zone from the collection.
  removeZone(GradZone zone)
  {
    _gradZones.remove(zone);
  }

  /// Returns the geojsons for the zones as a list.
  List<Map<String, dynamic>> geojsonsAsList()
  {
    List<Map<String, dynamic>> zones = [];
    for (GradZone zone in this)
    {
      zones.add(zone.getGeoJson());
    }
    return zones;
  }

  /// Returns the zone that has the given ID.
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

  /// Retrieves an iterator of this object as the collection of Zones.
  @override
  Iterator<GradZone> get iterator => _gradZones.iterator;

  /// Sets the == operator to check if the zones are the same.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GradZones &&
              runtimeType == other.runtimeType &&
              getZones() == other.getZones();

  /// Sets the hashcode to use the zones.
  @override
  int get hashCode => _gradZones.hashCode;
}