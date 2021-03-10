import 'lookupmessages.dart';

class VnMessages implements LookupMessages {
  String prefixAgo() => '';
  String prefixFromNow() => '';
  String suffixAgo() => 'trước';
  String suffixAgoDay() => ' trước tại';

  String suffixFromNow() => 'Bây giờ';
  String lessThanOneMinute(int seconds) => 'Hôm nay';
  String aboutAMinute(int minutes) => 'một phút';
  String minutes(int minutes) => '$minutes phút';
  String aboutAnHour(int minutes) => 'một giờ';
  String hours(int hours) => '$hours giờ';
  String aDay(int hours) => 'Hôm qua';
  String days(int days) => '$days ngày';
  String aboutAMonth(int days) => 'một tháng';
  String months(int months) => '$months tháng';
  String aboutAYear(int year) => 'một năm';
  String years(int years) => '$years năm';
  String wordSeparator() => ' ';
}
