import 'lookupmessages.dart';

class EnMessages implements LookupMessages {
  String prefixAgo() => '';
  String prefixFromNow() => '';
  String suffixAgo() => 'ago';
  String suffixAgoDay() => 'ago at';

  String suffixFromNow() => 'Now';
  String lessThanOneMinute(int seconds) => 'Today';
  String aboutAMinute(int minutes) => 'a minute';
  String minutes(int minutes) => '$minutes minutes';
  String aboutAnHour(int minutes) => 'an hour';
  String hours(int hours) => '$hours hours';
  String aDay(int hours) => 'Yesterday';
  String days(int days) => '$days days';
  String aboutAMonth(int days) => 'a month';
  String months(int months) => '$months months';
  String aboutAYear(int year) => 'a year';
  String years(int years) => '$years years';
  String wordSeparator() => ' ';
}

class EnShortMessages implements LookupMessages {
  String prefixAgo() => '';
  String prefixFromNow() => '';
  String suffixAgo() => '';
  String suffixAgoDay() => '';
  String suffixFromNow() => '';
  String lessThanOneMinute(int seconds) => 'now';
  String aboutAMinute(int minutes) => '1 min';
  String minutes(int minutes) => '$minutes min';
  String aboutAnHour(int minutes) => '~1 h';
  String hours(int hours) => '$hours h';
  String aDay(int hours) => '~1 d';
  String days(int days) => '$days d';
  String aboutAMonth(int days) => '~1 mo';
  String months(int months) => '$months mo';
  String aboutAYear(int year) => '~1 yr';
  String years(int years) => '$years yr';
  String wordSeparator() => ' ';
}
