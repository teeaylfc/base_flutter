import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:oev_timesheet/src/widgets/button_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomButtom extends StatelessWidget {
  String title;
  LinearGradient gradient;
  Function onTap;
  bool loading;
  String image;
  Color color;
  Function onTapRevert;
  String titleRevert;
  BottomButtom({
    this.title = '',
    this.gradient,
    this.onTap,
    this.image,
    this.color = Colors.white,
    this.loading = false,
    this.onTapRevert,
    this.titleRevert,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(20)),
      height: ScreenUtil().setSp(onTapRevert != null ? 110 : 75),
      child: Column(
        children: [
          onTapRevert != null
              ? ButtonBase(
                  loading: loading,
                  height: ScreenUtil().setSp(44),
                  onTap: loading == true ? null : onTapRevert,
                  borderRadius: ScreenUtil().setSp(100),
                  title: titleRevert,
                  fontSize: ScreenUtil().setSp(16),
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xFFEB5757), Color(0xFFEB5757)],
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      stops: const <double>[0.0, 1],
                      tileMode: TileMode.clamp),
                )
              : Container(),
          SizedBox(
            height: ScreenUtil().setSp(10),
          ),
          ButtonBase(
            loading: onTapRevert != null ? null : loading,
            height: ScreenUtil().setSp(44),
            onTap: onTap,
            borderRadius: ScreenUtil().setSp(100),
            title: title,
            fontSize: ScreenUtil().setSp(16),
            gradient: CommonColor.commonButtonColor,
          ),
          SizedBox(
            height: ScreenUtil().setSp(onTapRevert != null ? 10 : 0),
          ),
        ],
      ),
    );
  }
}
