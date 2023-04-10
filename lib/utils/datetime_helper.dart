import 'package:intl/intl.dart';

class DatetimeHelper {
  static DateTime format() {
    var now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = '11:00:00';
    final completeFormat = DateFormat('y/M/d H:m:s');

    // Today Format
    final todayFormat = dateFormat.format(now);
    final todayDateAndTime = '$todayFormat $timeSpecific';
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tomorrow Format
    final tomorrowFormat = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(tomorrowFormat);
    final tomorrowDateAndTime = '$tomorrowDate $timeSpecific';
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
