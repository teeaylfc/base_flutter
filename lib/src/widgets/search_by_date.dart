import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/common/util/date_format.dart';

// ignore: must_be_immutable
class SearchByDate extends StatefulWidget {
  DateTime fromDate;
  DateTime toDate;
  Function onChangeFromDate;
  Function onChangeToDate;
  SearchByDate(
      {Key key,
      this.fromDate,
      this.toDate,
      this.onChangeFromDate,
      this.onChangeToDate})
      : super(key: key);
  @override
  SearchByDateState createState() => SearchByDateState();
}

class SearchByDateState extends State<SearchByDate>
    with AutomaticKeepAliveClientMixin {
  var localType;
  @override
  void initState() {
    // fromDate = widget.fromDate;
    // toDate = widget.toDate;
    localType = current_lang == LanguageSetting.LANGUAGE_VI
        ? LocaleType.vi
        : LocaleType.en;
    // TODO: implement initState
    super.initState();
  }

  _datePickerStart() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      maxTime: widget.toDate,
      onConfirm: (date) {
        widget.onChangeFromDate(date);
      },
      currentTime: widget.fromDate,
      locale: localType,
    );
  }

  _datePickerEnd() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: widget.fromDate,
      onChanged: (date) {},
      onConfirm: (date) {
        widget.onChangeToDate(date);
      },
      currentTime: widget.toDate,
      locale: localType,
    );
  }

  String getFromDate() {
    return widget.fromDate != null
        ? widget.fromDate.toString().substring(0, 10)
        : null;
  }

  String getToDate() {
    return widget.toDate != null
        ? widget.toDate.toString().substring(0, 10)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen,
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setSp(10)),
      child: Row(
        children: <Widget>[
          _inputSearch(
            title: "dd/mm/yyyy",
            value: widget.fromDate,
            enable: false,
            onTap: _datePickerStart,
          ),
          Container(
            child: Text(
              FlutterI18n.translate(
                context,
                'transactionPage.to',
              ),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Colors.white,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(10)),
          ),
          _inputSearch(
              title: "dd/mm/yyyy",
              value: widget.toDate,
              enable: false,
              onTap: _datePickerEnd),
        ],
      ),
    );
  }

  _inputSearch({onTap, value, title, enable, errorText = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? null,
        child: Container(
          alignment: Alignment.center,
          height: ScreenUtil().setSp(30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setSp(8)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: ScreenUtil().setSp(8),
              ),
              Expanded(
                child: Text(
                  value != null
                      ? DateFormatCustom.dateFormat(value.toString())
                      : title,
                  style: TextStyle(
                      color:
                          value != null ? Color(0xff1F1F32) : Color(0xFF828282),
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          value != null ? FontStyle.normal : FontStyle.italic),
                ),
              ),
              enable
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(5),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: ScreenUtil().setSp(15),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
