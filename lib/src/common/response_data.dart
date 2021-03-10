import 'package:dio/dio.dart';

class ResponseData extends Response{
  var data;
  bool result;
  int code;
  var headers;

  ResponseData(this.data, this.result, this.code, {this.headers});
}