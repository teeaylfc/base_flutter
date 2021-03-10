import 'dart:async';
import 'dart:convert';

import 'package:oev_timesheet/src/blocs/bloc_provider.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/exception/http_check.dart';
import 'package:oev_timesheet/src/models/user_modal.dart';
import 'package:oev_timesheet/src/service/auth_service.dart';
import 'package:oev_timesheet/src/service/data_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oev_timesheet/src/service/notification_service.dart';
import 'package:rxdart/rxdart.dart';

enum AuthenticationState {
  notDetermined,
  notSignedIn,
  signedIn,
}

class ApplicationBloc extends BlocBase {
  final _storage = new FlutterSecureStorage();

  DataService dataService = DataService();
  AuthService authService = AuthService();
  final _currentUserController = BehaviorSubject<User>();
  final _authenticationStatusController = BehaviorSubject<bool>();
  final _currentLanguageController = BehaviorSubject<String>();
  final _notifyEventController = BehaviorSubject<String>();
  final _statusMessageDialog = BehaviorSubject<bool>(seedValue: true);

  //streams
  ValueObservable get getStatusMessageDialog => _statusMessageDialog.stream;

  Stream<User> get currentUser => _currentUserController.stream;

  Stream<bool> get authenticationStatus =>
      _authenticationStatusController.stream;

  Stream<String> get notifyEvent => _notifyEventController.stream;

  ValueObservable get getAuthStatus => _authenticationStatusController.stream;

  ValueObservable get currentUserValue => _currentUserController.stream;

  ValueObservable get currentLanguageValue => _currentLanguageController.stream;

  //sinks
  Function(User) get changeCurrentUser =>
      (user) => _currentUserController.sink.add(user);

  Function(bool) get changeAuthenticationStatus => (val) {
        _authenticationStatusController.sink.add(val);
      };

  Function(String) get changeCurrentLanguageValue =>
      (val) => _currentLanguageController.sink.add(val);

  Function(String) get changeNotifyEventValue =>
      (val) => _notifyEventController.sink.add(val);

  Function(bool) get changeStatusMessageDialog =>
      (status) => _statusMessageDialog.sink.add(status);

  ApplicationBloc() {
    getCurrentLanguage();
    _authenticationStatusController.sink.add(false);
    getCurrentUser();
    _currentUserController.stream.listen((user) {
      if (user != null) {
        _authenticationStatusController.sink.add(true);
      }
    });
  }

  getCurrentUser() async {
    String token = await _storage.read(key: Config.TOKEN_KEY);
    if (token != null) {
      _authenticationStatusController.sink.add(true);
    }
  }

  Future<bool> logout(context) async {
    // call api delete firebase token

    authService.signOut().then((value) {
      if (CheckApiError.callApiSuccess(value, context) == ErrorCode.SUCCESS) {
        clearUserData();
        removeOneSignalUser();
        return true;
      } else {
        return false;
      }
    });
  }

  getIdCompany() async {
    String id = await _storage.read(key: Config.TOKEN_KEY);
    return int.parse(id);
  }

  clearUserData() async {
    _authenticationStatusController.sink.add(false);
    changeCurrentUser(null);
    await _storage.delete(key: Config.TOKEN_KEY);
  }

  getCurrentLanguage() async {
    String language = await _storage.read(key: LanguageSetting.LANGUAGE);
    if (language == null) {
      language = LanguageSetting.LANGUAGE_EN;
    }
    changeLanguage(language);
  }

  changeLanguage(val) async {
    _currentLanguageController.sink.add(val);
    await _storage.write(key: LanguageSetting.LANGUAGE, value: val);
  }

  @override
  void dispose() {
    _currentUserController.close();
    _authenticationStatusController.close();
    _currentLanguageController.close();
    _notifyEventController.close();
    _statusMessageDialog.close();
  }
}

final statusToken = ApplicationBloc();
final applicationBloc = ApplicationBloc();
