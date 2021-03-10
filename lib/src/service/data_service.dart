import 'package:dio/dio.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/http_client.dart';


enum TOP_TYPE { BOOKED, REDEEMED, VIEWED, SEARCHED, REVIEWED, RATING }

class DataService {
  final size = Config.PAGE_SIZE;
  // Future<dynamic> getItemDetailToFullfill(qrCode) async {
  //   var langCode = current_lang == "en" ? "01" : "05";
  //   final response = await httpManager.get(
  //       '$baseApiUrl/api/merchant/itemDetails/$qrCode?languageCode=$langCode',
  //       null);
  //   return response;
  // }



 
}

final dataService = DataService();
