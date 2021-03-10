import 'package:flutter_svg/flutter_svg.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePopup extends StatelessWidget {
  final bool success;
  final String title1;
  final String title2;
  final String ogbjectId;
  final Function onNavititle2;

  const MessagePopup(
      {this.success,
      this.title1,
      this.title2,
      this.ogbjectId,
      this.onNavititle2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setSp(60)),
      child: CupertinoActionSheet(actions: <Widget>[
        CupertinoActionSheetAction(
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenUtil().setSp(10),
                ),
                success
                    ? SvgPicture.asset(
                        "assets/images/merchant/check_ok_icon.svg",
                        width: ScreenUtil().setSp(30),
                      )
                    : Icon(
                        Icons.error,
                        color: Colors.red,
                        size: ScreenUtil().setSp(30),
                      ),
                SizedBox(
                  width: ScreenUtil().setSp(5),
                ),
                Expanded(
                  child: Text(
                    title1 ?? '',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.bold,
                        color: success ? CommonColor.textBlack : Colors.red),
                  ),
                ),
                Text(
                  ' ',
                ),
                GestureDetector(
                  onTap: () {
                    onNavititle2();
                  },
                  child: Text(
                    title2 ?? '',
                    style: TextStyle(
                        color: CommonColor.textRed,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                )
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(ogbjectId);
          },
        )
      ]),
    );
  }
}
