import 'package:graduation_gathering/Map/Zones/colour.dart';
import 'package:test/test.dart';

void main() {
  group('Colour Tests', () {

    final Colour colour1 = Colour(0,0,0);
    final Colour colour2 = Colour(0,0,0);
    final Colour colour3 = Colour(255,255,255);

    test('== Same Colour', () {
      expect(colour1 == colour2, true);
    });

    test('== Different Colour', () {
      expect(colour1 == colour3, false);
    });

    test('== Different Object', () {
      expect(colour1 == "colour2", false);
    });

    test('== same Object', () {
      expect(colour1 == colour1, true);
    });
  });
}
