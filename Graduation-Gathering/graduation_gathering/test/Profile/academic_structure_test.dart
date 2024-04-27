import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:test/test.dart';

void main() {
  group('Academic Structure tests', () {

    AcademicStructure structure = AcademicStructure({"Fac1": {"S11": {"C111", "C112"},
      "S12": {"C121", "C122"}}, "Fac2": {"S21": {"C211", "C212"}, "S22": {"C221", "C222"}}});

    test('.getFaculties()', () {
      expect(structure.getFaculties().toSet(), {"Fac1", "Fac2"});
    });

    test('.getSchoolsFromFaculty() valid Faculty', () {
      expect(structure.getSchoolsFromFaculty("Fac2")?.toSet(), {"S21", "S22"});
    });

    test('.getSchoolsFromFaculty() invalid Faculty', () {
      expect(structure.getSchoolsFromFaculty("NotAFac"), null);
    });

    test('.getCoursesFromSchoolAndFaculty() valid Faculty and School', () {
      expect(structure.getCoursesFromSchoolAndFaculty("S12", "Fac1")?.toSet(), {"C121", "C122"});
    });

    test('.getCoursesFromSchoolAndFaculty() invalid Faculty and school', () {
      expect(structure.getCoursesFromSchoolAndFaculty("NotASch", "NotAFac"), null);
    });
  });
}
