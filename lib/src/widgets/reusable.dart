import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:oev_timesheet/src/blocs/application_bloc.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/common/http_client.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'notification_popup.dart';

class Reusable {
  static get statusBarTopShadow {
    return Container(
      height: ScreenUtil().setSp(90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 0.5),
          colors: [const Color(0x77000000), const Color(0x00000000)],
        ),
      ),
    );
  }

  static loadingProgress(orientation) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setSp(100),
          right: ScreenUtil().setSp(20),
          left: ScreenUtil().setSp(20),
          bottom: ScreenUtil().setSp(40)),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget backArrow(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(26)),
        margin: EdgeInsets.only(top: ScreenUtil().setSp(30)),
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  static void showTotastError(String errorMsg) {
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    throw (errorMsg);
  }


  static void showMessageDialog(success, text, context,
      {Function function, time = 10, title2, onNaviTitle2}) {
    containerForSheet<String>(
        context: context,
        child: Container(
          child: MessagePopup(
            success: success,
            title1: text,
            title2: title2,
            onNavititle2: () => onNaviTitle2(),
          ),
        ),
        function: function,
        time: time);
  }

  static void containerForSheet<T>(
      {BuildContext context, Widget child, Function function, time}) {
    if (statusToken.getStatusMessageDialog.value == false) {
      Navigator.pop(context);
      statusToken.changeStatusMessageDialog(true);
    }
    statusToken.changeStatusMessageDialog(false);
    showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: time), () {
            Navigator.pop(context);
          });

          return child;
        }).then<void>((T value) {
      statusToken.changeStatusMessageDialog(true);
      function();
    });
  }

  static void showTotastSuccess(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: ScreenUtil().setSp(16),
    );
    throw (msg);
  }

  static showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String text,
      {duration: 1400, String actionText, Function actionCallback}) {
    Future.delayed(Duration.zero, () {
      var snackBarAction;
      if (actionText != null && actionCallback != null) {
        snackBarAction = SnackBarAction(
            label: actionText,
            onPressed: () {
              actionCallback();
            });
      }

      var snackBar = SnackBar(
          action: snackBarAction,
          duration: Duration(milliseconds: duration),
          content: Text(text, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red);
      _scaffoldKey.currentState.showSnackBar(snackBar);
    });
  }

  static handleHttpError(context, error, [applicationBloc]) {
    if (error.action == HttpActionError.LOGIN) {
      // TODO
      // applicationBloc.logout();
      // Navigator.of(context).push(new CupertinoPageRoute<Null>(
      //     builder: (BuildContext context) {
      //       return SignInPage();
      //     },
      //     fullscreenDialog: true));
    } else {
      Reusable.showTotastError(error.message);
    }
  }
}
