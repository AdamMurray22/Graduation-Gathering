import '../account_type.dart';

/// Profile for a different user that this user has a connection with.
/// Meant for display on the connections screen.
class ConnectionProfile
{
  final String _id;
  final String _email;
  late final AccountType _accountType;
  String? _name;
  String? _faculty;
  String? _school;
  String? _course;

  ConnectionProfile(this._id, this._email, String accountType, String? name,
      String? faculty, String? school, String? course)
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

  /// Returns the main text to display for this user, its their name unless
  /// they haven't set their name, in that case its their email.
  String getMainText()
  {
    if (getName() != null)
    {
      return getName()!;
    }
    return getEmail();
  }

  /// Returns the sub text, it's their email unless that was the main text.
  String getSubText()
  {
    if (getName() != null)
    {
      return getEmail();
    }
    return "";
  }

  /// Returns the account type as a string.
  String getAccountTypeString()
  {
    return getAccountType().accountTypeAsString;
  }

  /// Returns the Id.
  String getId()
  {
    return _id;
  }

  /// Returns the email.
  String getEmail()
  {
    return _email;
  }

  /// Returns the account type object.
  AccountType getAccountType()
  {
    return _accountType;
  }

  /// Returns the name of the user.
  String? getName()
  {
    return _name;
  }

  /// Returns the Faculty of the user.
  String? getFaculty()
  {
    return _faculty;
  }

  /// Returns the School of the user.
  String? getSchool()
  {
    return _school;
  }

  /// Returns the Course of the user.
  String? getCourse()
  {
    return _course;
  }

  /// Sets the == operator to check if all the settings are the same.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ConnectionProfile &&
              runtimeType == other.runtimeType &&
              getId() == other.getId() &&
              getEmail() == other.getEmail() &&
              getName() == other.getName() &&
              getAccountType() == other.getAccountType() &&
              getFaculty() == other.getFaculty() &&
              getSchool() == other.getSchool() &&
              getCourse() == other.getCourse();

  /// Sets the hashcode to use all the settings.
  @override
  int get hashCode => _id.hashCode + _email.hashCode + _name.hashCode
      + _accountType.hashCode + _faculty.hashCode + _school.hashCode + _course.hashCode;
}