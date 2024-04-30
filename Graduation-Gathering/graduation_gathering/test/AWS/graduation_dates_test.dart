import 'package:graduation_gathering/AWS/graduation_dates.dart';
import 'package:test/test.dart';

void main() {
  group('Auth token tests', () {

    test('.isGraduationDay No dates', () {
      final GraduationDates date = GraduationDates([]);
      expect(date.isGraduationDay(DateTime(2024, 04, 03, 15)), false);
    });

    test('.isGraduationDay is the day', () {
      final GraduationDates date = GraduationDates(["2024/04/10"]);
      expect(date.isGraduationDay(DateTime(2024, 04, 10, 15)), true);
    });

    test('.isGraduationDay is not the day', () {
      final GraduationDates date = GraduationDates(["2024/04/10", "2024/01/30"]);
      expect(date.isGraduationDay(DateTime(2024, 04, 03, 07)), false);
    });
  });
}
