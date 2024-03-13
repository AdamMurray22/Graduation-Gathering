import 'package:graduation_gathering/Profile/account_type.dart';

import '../Map/Zones/grad_zones.dart';
import 'Connections/connections.dart';

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

  Map<String, dynamic> toJson()
  {
    return {'id': getId(), 'hasLoggedInBefore': getHasLoggedInBefore(), 'email': getEmail(),
      'accountType': getAccountType().accountTypeAsString, 'name': getName(), 'faculty': getFaculty(),
      'school': getSchool(), 'course': getCourse(), 'userGradZoneIds': _userGradZones.getIds()};
  }

  setHasLoggedInBefore(bool hasLoggedIn)
  {
    _hasLoggedInBefore = hasLoggedIn;
  }

  setName(String? name)
  {
    _name = name;
  }

  setFaculty(String? faculty)
  {
    _faculty = faculty;
  }

  setSchool(String? school)
  {
    _school = school;
  }

  setCourse(String? course)
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

  AccountType getAccountType()
  {
    return _accountType;
  }

  GradZones getUserGradZones()
  {
    return _userGradZones;
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