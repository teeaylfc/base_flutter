import 'package:oev_timesheet/src/blocs/auth_bloc.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/http_client.dart';
import 'package:oev_timesheet/src/service/data_service.dart';
import 'package:oev_timesheet/src/style/color.dart';

class AuthService {
  final String _loginUrl = baseApiUrl;

  DataService dataService = DataService();

  final _storage = new FlutterSecureStorage();

  Future<dynamic> login(username, password) async {
    try {
      var response =
          await httpManager.post(_loginUrl + '/api/merchant/authenticate', {
        'userId': username,
        'validationPin': password,
        "languageCode": current_lang == "en" ? "01" : "05",
      });
    } on DioError catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception(error.toString());
      }
    }
  }

  Future<dynamic> signOut() async {
    final response =
        await httpManager.get('$baseApiUrl/api/merchant/logout', null);
    return response;
  }
}
