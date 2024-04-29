import 'package:graduation_gathering/Map/Zones/colour.dart';
import 'package:graduation_gathering/Map/Zones/grad_zone.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:test/test.dart';

void main() {
  group('Gra zones Tests', () {

    final GradZones zones = GradZones.preformedZones([
      GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
      GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0))
    ]);

    test('.getZones()', () {
      expect(zones.getZones(), {
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
        GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0))
      });
    });

    test('.getZonesInOrder()', () {
      expect(zones.getZonesInOrder(), [
        GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0)),
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0))
      ]);
    });

    test('.getIds()', () {
      expect(zones.getIds(), {
        "testidA2", "testidB1"
      });
    });

    test('.geojsonsAsList()', () {
      expect(zones.geojsonsAsList().toSet(), {
        {"testGeoJson2A": "body2A"}, {"testGeoJson1B": "body1B"}
      });
    });

    test('.addZone()', () {
      final GradZones zonesTest = GradZones.preformedZones([
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
      ]);
      expect(zonesTest.getZones(), {
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
      });
      zonesTest.addZone(GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0)));
      expect(zonesTest.getZones(), {
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
        GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0))
      });
    });

    test('.removeZone()', () {
      final GradZones zonesTest = GradZones.preformedZones([
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
        GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0))
      ]);
      expect(zonesTest.getZones(), {
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
        GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0))
      });
      zonesTest.removeZone(GradZone({"id": "testidA2", "name": "testNameA", "geojson": {"testGeoJson2A": "body2A"}}, Colour(0,0,0)));
      expect(zonesTest.getZones(), {
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0)),
      });
    });

    test('.getZoneFromId()', () {
      expect(zones.getZoneFromId("testidB1"),
        GradZone({"id": "testidB1", "name": "testNameB", "geojson": {"testGeoJson1B": "body1B"}}, Colour(0,0,0))
      );
    });
  });
}
