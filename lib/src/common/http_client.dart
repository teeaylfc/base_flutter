import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:oev_timesheet/src/blocs/application_bloc.dart';
import 'package:oev_timesheet/src/blocs/bottom_navbar_bloc.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/interceptor/header_interceptor.dart';
import 'package:oev_timesheet/src/common/interceptor/jwt_token_interceptor.dart';
import 'package:oev_timesheet/src/common/interceptor/log_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:oev_timesheet/src/widgets/reusable.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = Dio();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptors());
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(LogsInterceptors());
    // _dio.interceptors.add(ResponseInterceptors());
  }

  requestHttp(url, params, Map<String, dynamic> header, Options option,
      {internet_connection}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());

    // /no network
    if (connectivityResult == ConnectivityResult.none) {
      if (internet_connection == true) {
        internetBloc.changeStatusInternet(true);
      } else {
        if (current_lang == LanguageSetting.LANGUAGE_EN) {
          throw HttpError(message: 'No internet connection! Please try again');
        } else {
          throw HttpError(
              message: 'Không có kết nối internet! Vui lòng thử lại');
        }
      }
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
      if (response.data["errorCode"] == ErrorCode.LOGIN) {
        statusToken.changeAuthenticationStatus(false);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) => SignInPage(),
        //   ),
        //   (Route<dynamic> route) => false,
        // );
      }
    } on DioError catch (e) {
      HttpError httpError = HttpError();
      httpError.statusCode = e.response?.statusCode;

      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 406 ||
          e.response?.statusCode == 403) {
        httpError.action = HttpActionError.LOGIN;
        statusToken.changeAuthenticationStatus(false);
      } else if (e.response?.statusCode == 400) {
        httpError.message = e.response.data["title"];
      } else if (e.response?.statusCode == 404) {
        httpError.message = e.response.data["message"];
      } else if (e.response != null && e.response.data != null) {
        if (e.response.data["message"] != null) {
          httpError.message = e.response.data["message"];
        } else if (current_lang == LanguageSetting.LANGUAGE_EN) {
          httpError.message = 'Oops! Something went wrong';
        } else {
          httpError.message = 'Oops! Có lỗi xảy ra';
        }
      }
      // else if (e.message != null) {
      //   httpError.message = e.message;
      // }
      else {
        httpError.message = _handleError(e);
      }

      throw (httpError);
    }
    return response?.data;
  }

  get(url, params, {internet_connection}) async {
    return await requestHttp(url, params, null, null,
        internet_connection: internet_connection);
  }

  post(url, params, {internet_connection}) async {
    return await requestHttp(url, params, null, Options(method: "post"),
        internet_connection: internet_connection);
  }

  put(url, params) async {
    return await requestHttp(url, params, null, Options(method: "put"));
  }

  delete(url, params) async {
    return await requestHttp(url, params, null, Options(method: "delete"));
  }

  _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Unable to establish connection with the server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "Connection to server failed";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "SEND_TIMEOUT";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}

final HttpManager httpManager = HttpManager();

class HttpError {
  HttpError({this.statusCode, this.message, this.action});

  int statusCode;
  String message;
  HttpActionError action;
}

enum HttpActionError {
  LOGIN,
  DEFAULT,
}
