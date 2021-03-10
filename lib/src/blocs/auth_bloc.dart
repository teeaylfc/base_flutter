import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oev_timesheet/src/blocs/bloc_provider.dart';
// import 'package:oev_timesheet/src/models/account_info_model.dart';
import 'package:oev_timesheet/src/models/bloc_delegate.dart';
import 'package:oev_timesheet/src/models/load_state.dart';
import 'package:oev_timesheet/src/models/user_modal.dart';
import 'package:oev_timesheet/src/service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  AuthService authService = AuthService();
  BlocDelegate<User> delegate;

  final _loadingStateController = StreamController<LoadState>();
  final _loginController = StreamController<Map>();
  final _typeBranchController = BehaviorSubject<bool>();

  ValueObservable<bool> get themeDataStream => _typeBranchController.stream;
  Function(bool) get checkTypeBranch =>
      (value) => _typeBranchController.sink.add(value);

  Stream<LoadState> get loadState => _loadingStateController.stream;

  Function(LoadState) get changeLoadState =>
      (loadState) => _loadingStateController.sink.add(loadState);

  AuthBloc({this.delegate});

  login(username, password) async {
    _startAuthProcess(() {
      return authService.login(username, password);
    });
  }

  _startAuthProcess(Future<dynamic> Function() authResponse) async {
    try {
      _loadingStateController.sink.add(Loading());
      _loadingStateController.sink.add(Loaded());
      User user = User();

      delegate.success(user);
    } catch (error) {
      changeLoadState(Loaded());
      delegate.error(error);
    }
  }

  @override
  void dispose() {
    _loginController.close();
    _loadingStateController.close();
    _typeBranchController.close();
  }
}

final authBloc = AuthBloc();
