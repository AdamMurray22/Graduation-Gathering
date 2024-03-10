class AcademicStructure
{
  final Map<String, Map<String, Set<String>>> _structure = Map<String, Map<String, Set<String>>>();

  AcademicStructure(Map<String, dynamic> structure)
  {
    print(structure);
    structure.forEach((key, value) {_structure[key] = {};
    for (String valueKey in (value as Map<String, dynamic>).keys)
    {
      _structure[key]![valueKey] = <String>{};
      for (String valueValue in (value[valueKey]))
      {
        print({key: valueKey});
        _structure[key]![valueKey]!.add(valueValue);
      }
    }
    });
    print(_structure);
  }

  Iterable<String> getFaculties()
  {
    return _structure.keys;
  }

  Iterable<String>? getSchoolsFromFaculty(String faculty)
  {
    return _structure[faculty]?.keys;
  }

  Iterable<String>? getCoursesFromSchoolAndFaculty(String school, String faculty)
  {
    return _structure[faculty]?[school];
  }
}