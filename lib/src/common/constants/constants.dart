import 'package:flutter/material.dart';

// OE DEV Server
// const String fileApiUrl = 'http://118.70.177.14:9090/api/files/';
// const String baseApiUrl = 'http://118.70.177.14:9335';

// MB UAT Server
// const String fileApiUrl = 'http://10.1.27.126:8123/api/files/';
// const String baseApiUrl = 'http://10.1.27.126:8126';

// MB LIVE Server
const String baseApiUrl = 'https://pbts.oneempower.com.vn:8443';

const String oneSignalAppId = '6010ae48-0c6c-4a71-9fd0-9974f5089084';

String ddMMyyyyHHmm = "dd/MM/yyyy HH:mm";

String FONT_FAMILY = "Averta";

String current_lang = null;

var globals = GlobalKey<NavigatorState>();

class Config {
  static const CONNECTION_TIMEOUT = 30000;
  static const PAGE_SIZE = 20;
  static const DEBUG = true;
  static const KEEP_USERID = 'KEEP_USERID';
  static const KEEP_PASSWORD = 'KEEP_PASSWORD';

  static const TOKEN_KEY = "jwt-token";
  static const USER_INFO = "user-info";
  static const USER_FULLNAME = "user-fullname";
  static const FIREBASE_TOKEN = "firebase-token";
  static const CSN = "csn";

  static const USER_EMAIL = "user-email";
  static const LIST_ORDER = "list-order";
}

class TypePieChart {
  static const ORDER = "OD";
  static const ACQUIRE = "AQ";
}

class NotificationStatusSeen {
  static const SEEN = 2;
  static const NOT_SEEN = 1;
}

class ErrorCode {
  static const SUCCESS = "00";
  static const LOGIN = "E607";
  static const WRONG_TERMINAL = "E730";
}

enum QRCODE_TYPE { POS_ID, RECEIPT }

enum ConfirmAction { CANCEL, ACCEPT }

class LanguageSetting {
  static const LANGUAGE_PATH = 'resources/langs';
  static const LANGUAGE = "language";
  static const LANGUAGE_VI = "vi";
  static const LANGUAGE_EN = "en";
}
