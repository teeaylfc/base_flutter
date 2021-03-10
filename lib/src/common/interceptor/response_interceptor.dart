import 'package:oev_timesheet/src/common/exception/http_code.dart';
import 'package:oev_timesheet/src/common/response_data.dart';
import 'package:dio/dio.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    try {
      return super
          .onResponse(ResponseData(response.data, true, HttpCode.SUCCESS));
    } catch (e) {
      return super.onResponse(ResponseData(
          response.data, false, response.statusCode,
          headers: response.headers));
    }
  }
}
