import 'package:graduation_gathering/Map/tile_server.dart';
import 'package:test/test.dart';

void main() {
  group('Tile server Tests', () {

    final TileServer validServer = TileServer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", "valid test attribute");
    final TileServer invalidServer = TileServer("", "invalid test attribute");
    test('.getURL() tile server', () {
      expect(validServer.url, "https://tile.openstreetmap.org/{z}/{x}/{y}.png");
    });

    test('.getAttribution() valid landmark', () {
      expect(validServer.attribution, "valid test attribute");
    });

    test('.getUrlDomains() valid tile server', () {
      expect(validServer.getUrlDomains(), "tile.openstreetmap.org");
    });

    test('.getUrlDomains() invalid tile server', () {
      expect(invalidServer.getUrlDomains(), null);
    });
  });
}
