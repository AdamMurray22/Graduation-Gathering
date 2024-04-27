import 'package:graduation_gathering/Exceptions/map_data_id_not_found_exception.dart';
import 'package:graduation_gathering/Map/map_data_id.dart';
import 'package:test/test.dart';

void main() {
  group('Map Data Id Tests', () {
    test('.getMapDataIdEnumFromId() valid other user', () {
      expect(MapDataId.getMapDataIdEnumFromId("OU-873949"), MapDataId.otherUsers);
    });

    test('.getMapDataIdEnumFromId() valid grad zone', () {
      expect(MapDataId.getMapDataIdEnumFromId("GZ-9052"), MapDataId.zones);
    });

    test('.getMapDataIdEnumFromId() valid user location', () {
      expect(MapDataId.getMapDataIdEnumFromId("UL-93455-"), MapDataId.userLocation);
    });

    test('.getMapDataIdEnumFromId() invalid id', () {
      expect(
        () => MapDataId.getMapDataIdEnumFromId("invalid"),
        throwsA(
          isA<MapDataIdNotFoundException>().having(
            (error) => error.message,
            'message',
            'Id not found.',
          ),
        ),
      );
    });
  });
}
