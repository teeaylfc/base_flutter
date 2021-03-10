import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';

class ButtonBase extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double height;
  final double width;
  final LinearGradient gradient;
  final Color backgroundColor;
  final Function onTap;
  final String title;
  final double fontSize;
  final Color textColor;
  final double borderRadius;
  final Widget child;
  bool loading;
  BoxBorder border;
  List<BoxShadow> shadow;
  ButtonBase(
      {Key key,
      this.height,
      this.width,
      this.textColor,
      this.padding,
      this.gradient,
      this.onTap,
      this.backgroundColor,
      this.title,
      this.fontSize,
      this.borderRadius,
      this.child,
      this.loading,
      this.border,
      this.margin,
      this.shadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        gradient: gradient ?? null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          borderRadius ?? ScreenUtil().setSp(10),
        ),
        boxShadow: shadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(borderRadius ?? ScreenUtil().setSp(10)),
          onTap: loading == true ? null : onTap,
          child: Container(
              padding: padding,
              alignment: Alignment.center,
              child: renderContent()),
        ),
      ),
    );
  }

  renderContent() {
    if (child != null) return child;
    return Stack(alignment: Alignment.center, children: [
      Center(
        child: Text(
          title ?? "",
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? ScreenUtil().setSp(14),
          ),
        ),
      ),
      loading == true
          ? Positioned(
              right: 8,
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: ScreenUtil().setSp(22),
              ),
            )
          : Container()
    ]);
  }
}
