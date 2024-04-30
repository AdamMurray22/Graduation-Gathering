import 'package:graduation_gathering/AWS/graduation_date.dart';

class GraduationDates extends Iterable<GraduationDate>
{
  final Set<GraduationDate> _dates = {};

  GraduationDates(List<dynamic> dates)
  {
    for (String date in dates)
    {
      _dates.add(GraduationDate(date));
    }
  }

  /// Returns if the current date and time is during a graduation day.
  bool isGraduationDayToday()
  {
    return isGraduationDay(DateTime.now());
  }

  /// Returns if the given date and time is during a graduation day.
  bool isGraduationDay(DateTime dateTime)
  {
    for (GraduationDate date in _dates)
    {
      if (date.isGraduationDay(dateTime) == true)
      {
        return true;
      }
    }
    return false;
  }

  @override
  // TODO: implement iterator
  Iterator<GraduationDate> get iterator => _dates.iterator;

}