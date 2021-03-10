import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:dio/dio.dart';

class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (Config.DEBUG) {
      print("Request URL: ${options.path}");
      print('Request header: ' + options.headers.toString());
      if (options.data != null) {
        print('Request parameter: ' + options.data.toString());
      }
    }
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    if (Config.DEBUG) {
      if (response != null) {
        print('Response: ' + response.toString());
      }
    }
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    if (Config.DEBUG) {
      print('Request exception: ' + err.toString());
      print('Request exception information: ' + err.response?.toString() ?? "");
    }
    return super.onError(err);
  }
}
