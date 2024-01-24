class ParseEmail
{
  final String _startOfEmail =
      '(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")';
  late final RegExp _studentEmail;
  late final RegExp _staffEmail;

  ParseEmail()
  {
    _studentEmail = RegExp('$_startOfEmail@myport.ac.uk');
    _staffEmail = RegExp('$_startOfEmail@port.ac.uk');
  }

  bool validate(String email)
  {
    email = email.trim();
    return _studentEmail.hasMatch(email) || _staffEmail.hasMatch(email);
  }
}