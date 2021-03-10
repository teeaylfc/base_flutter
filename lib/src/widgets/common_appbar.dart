import 'package:flutter/material.dart';

import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/style/color.dart';

double heightHeader = ScreenUtil().setSp(20);

// ignore: must_be_immutable
class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool filter;
  final Size preferredSize;
  CommonAppbar({
    Key key,
    this.title,
    this.filter,
  })  : preferredSize = Size.fromHeight(55),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      bottom: PreferredSize(
        child: rowHeader(context),
        preferredSize: Size.fromHeight(ScreenUtil().setSp(40)),
      ),
    );
  }

  Widget rowHeader(context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: ScreenUtil().setSp(40),
      padding: EdgeInsets.only(bottom: ScreenUtil().setSp(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Container(
              width: width * 0.11,
              padding: EdgeInsets.only(
                left: 0,
                top: ScreenUtil().setSp(5),
                bottom: ScreenUtil().setSp(5),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_ios,
                color: CommonColor.textGray1,
                size: ScreenUtil().setSp(19),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: CommonColor.textGray1,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: filter == true ? filterAction : null,
            child: Container(
              color: Colors.transparent,
              width: width * 0.11,
              padding: EdgeInsets.only(
                top: ScreenUtil().setSp(5),
                bottom: ScreenUtil().setSp(5),
              ),
              alignment: Alignment.centerLeft,
              child: filter == true
                  ? Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                      size: ScreenUtil().setSp(19),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }

  filterAction() {}
}
