/// Checks if a given email is a valid student or staff email for the University
/// of Portsmouth.
class ParseEmail
{
  // Regex for the start of an email (every thing before the @) in String form.
  final String _startOfEmail =
      '(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")';
  // Regex object for a student email.
  late final RegExp _studentEmail;
  // Regex object for a staff email.
  late final RegExp _staffEmail;

  ParseEmail()
  {
    _studentEmail = RegExp('$_startOfEmail@myport.ac.uk');
    _staffEmail = RegExp('$_startOfEmail@port.ac.uk');
  }

  /// Validates a given email by whether it's a valid student or staff email for
  /// the University of Portsmouth
  bool validate(String email)
  {
    email = email.trim();
    return _studentEmail.hasMatch(email) || _staffEmail.hasMatch(email);
  }
}