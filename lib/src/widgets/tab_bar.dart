import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';

class TabBarWidget extends StatelessWidget {
  List<Widget> tabs;
  TabController _tabController;
  double height;
  double width;
  bool borderBottom;
  bool isScroll;
  TabBarWidget(this.tabs, this._tabController,
      {this.height = 38,
      this.width = 343,
      this.borderBottom = false,
      this.isScroll = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setSp(35),
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.blue,
        isScrollable: isScroll,
        labelPadding: isScroll
            ? EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(
                    current_lang == LanguageSetting.LANGUAGE_EN ? 21 : 10))
            : EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(5)),
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(12),
            fontFamily: FONT_FAMILY),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: ScreenUtil().setSp(12),
            fontFamily: FONT_FAMILY),
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xff9B9B9B),
        tabs: tabs,
      ),
    );
  }
}
