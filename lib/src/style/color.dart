import 'package:flutter/material.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';

class CommonColor {
  static Color textBlack = Color(0xFF2a2a2a);
  static Color textGray1 = Color(0xFF333333);

  static Color textRed = Color(0xFFFB0402);
  static Color textOrange = Color(0xFFEB5757);
  static Color commonGreen = Color(0xFF27AE60);
  static Color commonRed = Color(0xFFFB101B);
  static Color commonBlack = Color(0xFF0E0E0E);
  static Color commonOrange = Color(0xFFFA8526);
  static Color commonGrey = Color(0xFFE7E7E7);
  static Color commonYellow = Color(0xffF2994A);
  static Color commonGreenHome = Color(0xff32937B);
  static Color commonBlue = Color(0xff0371CD);
  static Color commonGreyHome = Color(0xff4F4F4F);
  static Color commonGreyBackground = Color(0xff333333);

  static Color headerStore = Color(0xff333333);
  static Color bodyStore = Color(0xFFFFFFFF);
  static Color textStore = Color(0xff2A2A2A);

  static Color headerBranch = Color(0xff0267B9);
  static Color bodyBranch = Color(0xff222222);
  static Color textBranch = Colors.white;

  static Color barChartColor = Color(0xffF76016);

  static Color commonColorBlackMB = Color(0xff0E0E0E);

  static Color voucherColor = const Color(0xffEFC136);
  static Color awardColor = const Color(0xffD56535);
  static Color redeemPointColor = const Color(0xff3CA2F8);

  static Color backgroundColor = Color(0xFFf2f2f2);

  static LinearGradient commonButtonColor = LinearGradient(
      colors: <Color>[Color(0xFF0371CD), Color(0xFF0267B9)],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      stops: const <double>[0.0, 1],
      tileMode: TileMode.clamp);
}
