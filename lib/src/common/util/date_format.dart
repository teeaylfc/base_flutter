import 'package:intl/intl.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';

class DateFormatCustom {
  static String dateFormat(date) {
    String s;
    DateTime d = DateFormat("yyyy-MM-dd HH:mm:ss", "en_US").parse(date);
    s = DateFormat("dd/MM/yyyy").format(d).toString();
    return s;
  }

  static String timeFormat(date) {
    String s;
    DateTime d = DateFormat("yyyy-MM-dd HH:mm:ss", "en_US").parse(date);
    s = DateFormat(ddMMyyyyHHmm).format(d).toString();
    return s;
  }

  static String dateFormatHaveT(date) {
    String s;
    DateTime d = DateFormat("yyyy-MM-ddTHH:mm:ss", "en_US").parse(date);
    s = DateFormat(ddMMyyyyHHmm).format(d).toString();
    return s;
  }

  static String dateFormatForTransaction(date) {
    String s;
    DateTime d = DateFormat("dd-MM-yyyy HH:mm:ss", "en_US").parse(date);
    s = DateFormat(ddMMyyyyHHmm).format(d).toString();
    return s;
  }

  static List<DateTime> dateSubtract(number) {
    List<DateTime> listDay = List<DateTime>();
    DateTime d = DateTime.now();
    for (var i = 6; i >= 0; i--) {
      DateTime dnew = DateTime(d.year, d.month, d.day - (i * number));
      listDay.add(dnew);
    }
    return listDay;
  }

  static List<DateTime> dateQuarter() {
    List<DateTime> listDay = List<DateTime>();
    DateTime d = DateTime.now();
    for (var i = 6; i >= 0; i--) {
      DateTime dnew = DateTime(d.year, d.month, d.day - (i * 15));
      listDay.add(dnew);
    }
    return listDay;
  }

  static int formatOnlyDate(date) {
    DateTime d = DateFormat("yyyy-MM-dd", "en_US").parse(date);
    return d.day;
  }

  static DateTime stringToDateTime(date) {
    DateTime d = DateFormat("yyyy-MM-dd", "en_US").parse(date);
    return d;
  }

  static String monthName(m) {
    // if (current_lang == LanguageSetting.LANGUAGE_EN) {
    switch (m) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
    }
    // } else {
    //   switch (m) {
    //     case 1:
    //       return "Th1";
    //       break;
    //     case 2:
    //       return "Th2";
    //       break;
    //     case 3:
    //       return "Th3";
    //       break;
    //     case 4:
    //       return "Th4";
    //       break;
    //     case 5:
    //       return "Th5";
    //       break;
    //     case 6:
    //       return "Th6";
    //       break;
    //     case 7:
    //       return "Th7";
    //       break;
    //     case 8:
    //       return "Th8";
    //       break;
    //     case 9:
    //       return "Th9";
    //       break;
    //     case 10:
    //       return "Th10";
    //       break;
    //     case 11:
    //       return "Th11";
    //       break;
    //     case 12:
    //       return "Th12";
    //       break;
    //   }
    // }
  }
}
