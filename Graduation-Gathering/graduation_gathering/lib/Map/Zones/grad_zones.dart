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

  @override
  Iterator<GradZone> get iterator => _gradZones.iterator;
}