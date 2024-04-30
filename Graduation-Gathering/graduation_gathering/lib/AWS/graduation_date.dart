import 'package:intl/intl.dart';

/// This represents a graduation day.
/// NOT the 24 hours of the day that a graduation happens on.
class GraduationDate
{
  final _dateFormat = DateFormat('yyyy/MM/dd');
  
  late final String _date;
  late final String _tomorrowDate;
  
  /// Constructor requires a date in the form:
  /// YYYY/MM/DD.
  GraduationDate(String date)
  {
    if (!_correctFormat(date))
    {
      throw ArgumentError("Date is not in the format YYYY/MM/DD.");
    }
    _date = date;
    DateTime dateTime = _dateFormat.parse(date);
    DateTime tomorrowDateTime = dateTime.add(const Duration(days: 1));
    _tomorrowDate = _dateFormat.format(tomorrowDateTime);
  }

  /// Returns if the current date is a graduation day.
  bool isGraduationDay(DateTime today) {
    String currentDate = _dateFormat.format(today);

    if (currentDate == _date) {
      if (today.hour >= 8) {
        return true;
      }
    }
    else {
      if (currentDate == _tomorrowDate) {
        if (today.hour < 1) {
          return true;
        }
      }
    }
    return false;
  }

  // Returns if a given string is a date in the format YYYY/MM/DD.
  bool _correctFormat(String date)
  {
    if (date.length != 10)
    {
      return false;
    }
    if (date[4] != '/' || date[7] != '/')
    {
      return false;
    }
    String year = date.substring(0, 4);
    if (int.tryParse(year) == null)
    {
      return false;
    }
    String month = date.substring(5, 7);
    if (int.tryParse(month) == null)
    {
      return false;
    }
    int monthAsInt = int.parse(month);
    if (monthAsInt < 0 || monthAsInt > 12)
    {
      return false;
    }
    String day = date.substring(8, 10);
    if (int.tryParse(day) == null)
    {
      return false;
    }
    int dayAsInt = int.parse(day);
    if (dayAsInt < 0 || dayAsInt > 31)
    {
      return false;
    }
    return true;
  }
}