import 'package:graduation_gathering/AWS/graduation_date.dart';
import 'package:test/test.dart';

void main() {
  group('Auth token tests', () {

    final GraduationDate date = GraduationDate("2024/04/03");

    test('.isGraduationDay is the day', () {
      expect(date.isGraduationDay(DateTime(2024, 04, 03, 15)), true);
    });

    test('.isGraduationDay is not the day', () {
      expect(date.isGraduationDay(DateTime(2024, 04, 10, 15)), false);
    });

    test('.isGraduationDay is the day but too early', () {
      expect(date.isGraduationDay(DateTime(2024, 04, 03, 07)), false);
    });

    test('.isGraduationDay is day but after midnight', () {
      expect(date.isGraduationDay(DateTime(2024, 04, 04, 0, 30)), true);
    });
  });
}
