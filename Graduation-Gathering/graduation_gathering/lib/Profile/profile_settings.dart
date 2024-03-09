class ProfileSettings
{
  late bool _hasLoggedInBefore;
  final String _id;
  final String _email;
  final String _accountType;
  String? _name;
  String? _faculty;
  String? _school;
  String? _course;

  ProfileSettings(hasLoggedInBefore, this._id, this._email, this._accountType, name, faculty, school, course)
  {
    _hasLoggedInBefore = (hasLoggedInBefore != 0);
    _name = name;
    if (name == "null")
    {
      _name = null;
    }
    _faculty = faculty;
    if (faculty == "null")
    {
      _faculty = null;
    }
    _school = school;
    if (school == "null")
    {
      _school = null;
    }
    _course = course;
    if (course == "null")
    {
      _course = null;
    }
  }

  setHasLoggedInBefore(bool hasLoggedIn)
  {
    _hasLoggedInBefore = hasLoggedIn;
  }

  setName(String name)
  {
    _name = name;
  }

  setFaculty(String faculty)
  {
    _faculty = faculty;
  }

  setSchool(String school)
  {
    _school = school;
  }

  setCourse(String course)
  {
    _course = course;
  }

  bool getHasLoggedInBefore()
  {
    return _hasLoggedInBefore;
  }

  String getId()
  {
    return _id;
  }

  String getEmail()
  {
    return _email;
  }

  String getAccountType()
  {
    return _accountType;
  }

  String? getName()
  {
    return _name;
  }

  String? getFaculty()
  {
    return _faculty;
  }

  String? getSchool()
  {
    return _school;
  }

  String? getCourse()
  {
    return _course;
  }
}