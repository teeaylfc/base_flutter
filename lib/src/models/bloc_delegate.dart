import 'package:oev_timesheet/src/common/http_client.dart';

abstract class BlocDelegate<T> {
  success(T t);
  error(HttpError errorMessage);
}
