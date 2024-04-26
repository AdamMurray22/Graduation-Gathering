import 'package:graduation_gathering/Profile/account_type.dart';

import '../Map/Zones/grad_zones.dart';

/// A users profile.
class ProfileSettings
{
  late bool _hasLoggedInBefore;
  final String _id;
  final String _email;
  late final AccountType _accountType;
  final GradZones _userGradZones;
  String? _name;
  String? _faculty;
  String? _school;
  String? _course;

  ProfileSettings(hasLoggedInBefore, this._id, this._email, accountType, name, faculty, school, course, this._userGradZones)
  {
    _hasLoggedInBefore = (hasLoggedInBefore != 0);
    _accountType = AccountType.getAccountTypeFromString(accountType)!;
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

  /// Returns the profile as a Map in the form String to primitive type.
  /// The keys are: id, hasLoggedInBefore, email, accountType, name, faculty,
  /// school, course, userGradZoneIds.
  Map<String, dynamic> toJson()
  {
    return {'id': getId(), 'hasLoggedInBefore': getHasLoggedInBefore(), 'email': getEmail(),
      'accountType': getAccountType().accountTypeAsString, 'name': getName(), 'faculty': getFaculty(),
      'school': getSchool(), 'course': getCourse(), 'userGradZoneIds': _userGradZones.getIds()};
  }

  /// Sets has logged in before.
  setHasLoggedInBefore(bool hasLoggedIn)
  {
    _hasLoggedInBefore = hasLoggedIn;
  }

  /// Sets the name.
  setName(String? name)
  {
    _name = name;
  }

  /// Sets the faculty.
  setFaculty(String? faculty)
  {
    _faculty = faculty;
  }

  /// Sets the school.
  setSchool(String? school)
  {
    _school = school;
  }

  /// Sets the course.
  setCourse(String? course)
  {
    _course = course;
  }

  /// Gets whether the user has logged in before.
  bool getHasLoggedInBefore()
  {
    return _hasLoggedInBefore;
  }

  /// Gets the id.
  String getId()
  {
    return _id;
  }

  /// Gets the email.
  String getEmail()
  {
    return _email;
  }

  /// Gets he account type.
  AccountType getAccountType()
  {
    return _accountType;
  }

  /// Gets the graduation zones that the user has selected to appear within.
  GradZones getUserGradZones()
  {
    return _userGradZones;
  }

  /// Gets the name.
  String? getName()
  {
    return _name;
  }

  /// Gets the faculty.
  String? getFaculty()
  {
    return _faculty;
  }

  /// Gets the school.
  String? getSchool()
  {
    return _school;
  }

  /// Gets the course.
  String? getCourse()
  {
    return _course;
  }
}