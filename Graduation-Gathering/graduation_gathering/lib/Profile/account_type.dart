/// Enum for the types of accounts users can have.
enum AccountType
{
  student("Student"),
  staff("Staff");

  const AccountType(this.accountTypeAsString);

  final String accountTypeAsString;

  /// Returns the account type enum that a string represents.
  static AccountType? getAccountTypeFromString(String accountTypeString)
  {
    if (accountTypeString.toLowerCase() == "student")
    {
      return AccountType.student;
    }
    else if (accountTypeString.toLowerCase() == "staff")
    {
      return AccountType.staff;
    }
    return null;
  }
}