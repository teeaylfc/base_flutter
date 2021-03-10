import 'dart:io';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:oev_timesheet/src/widgets/button_base.dart';
import 'package:oev_timesheet/src/widgets/raised_gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final bool avatarPreview;
  final File avatarFile;
  final String image;
  final String headline;
  final String title;
  final Function callbackConfirm;
  final Function callbackDone;
  final double width;
  final double height;
  final Widget inputText;
  final bool disPopConfirm;
  final bool typeRevert;
  final String doneRevert;
  const ConfirmDialog({
    this.avatarPreview = false,
    this.avatarFile,
    this.width,
    this.height,
    this.image,
    this.title,
    this.headline,
    this.callbackConfirm,
    this.callbackDone,
    this.inputText,
    this.disPopConfirm = false,
    this.typeRevert = false,
    this.doneRevert,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setSp(8),
        ),
      ),
      content: Container(
        width: ScreenUtil().setSp(297),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            image != null
                ? Image(
                    width: ScreenUtil().setSp(80),
                    height: ScreenUtil().setSp(113),
                    image: AssetImage(
                      image,
                    ))
                : avatarPreview && avatarFile != null
                    ? CircleAvatar(
                        radius: 40, backgroundImage: FileImage(avatarFile))
                    : Container(),
            SizedBox(
              height: ScreenUtil().setSp(10),
            ),
            headline != null
                ? Container(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
                    child: Text(
                      headline,
                      style: TextStyle(
                          color: CommonColor.commonBlue,
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
            title != null
                ? Container(
                    padding: EdgeInsets.only(
                        bottom: ScreenUtil().setSp(20),
                        left: ScreenUtil().setSp(15),
                        right: ScreenUtil().setSp(15)),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff2a2a2a),
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  )
                : Text(''),
            inputText ?? Container(),
            SizedBox(
              height: ScreenUtil().setSp(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCancelButton(context),
                _buildYesButton(context, 'CONFIRM'),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setSp(10),
            )
          ],
        ),
      ),
    );
  }

  _buildYesButton(context, type) {
    return RaisedGradientButton(
        child: Text(
          type == 'DONE'
              ? FlutterI18n.translate(context, 'homePage.done')
              : typeRevert
                  ? doneRevert
                  : FlutterI18n.translate(context, 'homePage.yes'),
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(14),
          ),
        ),
        borderRadius: ScreenUtil().setSp(30),
        gradient: LinearGradient(
            colors: <Color>[Color(0xFF0267B9), Color(0xFFF0267B9)],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            stops: const <double>[0.0, 1],
            tileMode: TileMode.clamp),
        width: ScreenUtil().setSp(100),
        height: ScreenUtil().setSp(35),
        onPressed: () {
          if (!disPopConfirm) {
            Navigator.of(context).pop(ConfirmAction.ACCEPT);
          }
          type == 'DONE' ? callbackDone() : callbackConfirm();
        });
  }

  _buildCancelButton(context) {
    return ButtonBase(
        child: Text(
          typeRevert
              ? FlutterI18n.translate(context, 'transactionPage.cancel')
              : FlutterI18n.translate(context, 'homePage.no'),
          style: TextStyle(
            color: Color(0xFF696969),
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(14),
          ),
        ),
        borderRadius: ScreenUtil().setSp(20),
        backgroundColor: Color(0xFFEAEAEA),
        width: ScreenUtil().setSp(100),
        height: ScreenUtil().setSp(35),
        onTap: () {
          Navigator.of(context).pop(ConfirmAction.CANCEL);
        });
  }
}
