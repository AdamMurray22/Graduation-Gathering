import '../account_type.dart';

class ConnectionProfile
{
  final String _id;
  final String _email;
  late final AccountType _accountType;
  String? _name;
  String? _faculty;
  String? _school;
  String? _course;

  ConnectionProfile(this._id, this._email, accountType, name, faculty, school, course)
  {
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

  String getMainText()
  {
    if (getName() != null)
    {
      return getName()!;
    }
    return getEmail();
  }

  String getSubText()
  {
    if (getName() != null)
    {
      return getEmail();
    }
    return "";
  }

  String getAccountTypeString()
  {
    return getAccountType().accountTypeAsString;
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