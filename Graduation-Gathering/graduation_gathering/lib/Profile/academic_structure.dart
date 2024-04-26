/// Holds the academic structure of the University of Portsmouth.
class AcademicStructure
{
  final Map<String, Map<String, Set<String>>> _structure = <String, Map<String, Set<String>>>{};

  AcademicStructure(Map<String, dynamic> structure)
  {
    structure.forEach((key, value) {_structure[key] = {};
    for (String valueKey in (value as Map<String, dynamic>).keys)
    {
      _structure[key]![valueKey] = <String>{};
      for (String valueValue in (value[valueKey]))
      {
        _structure[key]![valueKey]!.add(valueValue);
      }
    }
    });
  }

  /// Returns the collection of the Faculties.
  Iterable<String> getFaculties()
  {
    return _structure.keys;
  }

  /// Returns the collection of the schools from a given faculty.
  Iterable<String>? getSchoolsFromFaculty(String faculty)
  {
    return _structure[faculty]?.keys;
  }

  /// Returns the collection of the courses from a given school and faculty.
  Iterable<String>? getCoursesFromSchoolAndFaculty(String school, String faculty)
  {
    return _structure[faculty]?[school];
  }
}