import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/widgets/reusable.dart';

class CheckApiError {
  static String callApiSuccess(data, context,
      {hideMessage = false, thenPop = false}) {
    if (data['errorCode'] == ErrorCode.SUCCESS) {
      return ErrorCode.SUCCESS;
    } else {
      if (data['errorCode'] == ErrorCode.WRONG_TERMINAL) {
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   CupertinoPageRoute(builder: (contexte) => HomePage()),
        //   (Route<dynamic> route) => false,
        // );
      } else if (thenPop == true) {
        Navigator.pop(context);
      }
      if (hideMessage == false) {
        Reusable.showMessageDialog(
            false, data['errorCode'] + ": " + data['errorMessage'], context);
      }
      return data['errorMessage'];
    }
  }
}
