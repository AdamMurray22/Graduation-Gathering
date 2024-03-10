enum AccountType
{
  student("Student"),
  staff("Staff");

  const AccountType(this.accountTypeAsString);

  final String accountTypeAsString;

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