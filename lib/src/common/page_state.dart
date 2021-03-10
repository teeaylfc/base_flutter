import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

abstract class PageState<T extends StatefulWidget> extends State<T> {
  GlobalKey<EasyRefreshState> easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> footerKey = new GlobalKey<RefreshFooterState>();
  bool loading = false;
  var page = 1;
  bool last = false;
  Future loadMoreData();
  Future refreshData();
}
