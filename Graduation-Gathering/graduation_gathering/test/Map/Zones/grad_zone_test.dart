import 'package:graduation_gathering/Map/Zones/colour.dart';
import 'package:graduation_gathering/Map/Zones/grad_zone.dart';
import 'package:test/test.dart';

void main() {
  group('Tile server Tests', () {

    final GradZone zone = GradZone({"id": "testid", "name": "testName", "geojson": {"testGeoJson": "body"}}, Colour(0,0,0));

    test('.getId()', () {
      expect(zone.getId(), "testid");
    });

    test('.getColour()', () {
      expect(zone.getColour(), Colour(0,0,0));
    });

    test('.getName()', () {
      expect(zone.getName(), "testName");
    });

    test('.getGeoJson()', () {
      expect(zone.getGeoJson(), {"testGeoJson": "body"});
    });
  });
}
