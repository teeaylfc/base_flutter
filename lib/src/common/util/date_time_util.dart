import 'package:intl/intl.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/util/timeago/timeago.dart' as timeago;

class DateTimeUtil {
  // time ago
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    try {
      var formatter = DateFormat("dd-MM-yyyy HH:mm:ss");
      DateTime date = formatter.parse(dateString);
      final today = DateTime.now();
      // final difference = today.difference(date);

      String hhmm = date.hour.toString() +
          ':' +
          (date.minute.toString().length == 2
              ? date.minute.toString()
              : '0' + date.minute.toString());

      final difference = today.difference(date);
      return timeago.format(today.subtract(difference), hhmm, dateString,
          locale: current_lang == LanguageSetting.LANGUAGE_EN ? 'en' : 'vn');
    } catch (error) {
      return '';
    }
  }
}
