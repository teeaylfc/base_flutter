import 'dart:async';

import 'package:rxdart/rxdart.dart';

class PickItemBloc {
  final StreamController<dynamic> pickItemController =
      StreamController<dynamic>.broadcast();
  Stream<dynamic> get pickItemStream => pickItemController.stream;

  void seeAllStore() {
    pickItemController.sink.add(3);
  }

  walletPage() {
    pickItemController.sink.add(2);
  }

  void dispose() {
    pickItemController?.close();
  }
}

class GetSearchResult {
  final StreamController listSearchResultController =
      StreamController.broadcast();
  Stream get listSearchResultStream => listSearchResultController.stream;

  void getResult(data) {
    listSearchResultController.sink.add(data);
  }

  void dispose() {
    listSearchResultController?.close();
  }
}

class CheckInternetConnection {
  final _checkInternetController = BehaviorSubject<bool>(seedValue: false);
  ValueObservable get internetConnection => _checkInternetController.stream;

  Function(bool) get changeStatusInternet => (val) {
        _checkInternetController.sink.add(val);
      };

  void dispose() {
    _checkInternetController?.close();
  }
}

final pickItemBloc = PickItemBloc();
final internetBloc = CheckInternetConnection();
final getSearchResult = GetSearchResult();
