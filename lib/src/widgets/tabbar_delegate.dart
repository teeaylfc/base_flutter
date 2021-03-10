import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:flutter/material.dart';

class TabbarDelegate extends SliverPersistentHeaderDelegate {
  TabbarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(15), vertical: ScreenUtil().setSp(10)),
      color: CommonColor.commonBlue,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(TabbarDelegate oldDelegate) {
    return false;
  }
}
