import 'package:oev_timesheet/src/common/constants/constants.dart';

class User {
  final String username;
  final String fullName;
  final String imageURL;
  final int image;
  final double balance;

  int walletCount;

  User({this.username, this.fullName, this.imageURL, this.image, this.balance});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        fullName = json['fullName'],
        imageURL = json['imageURL'],
        image = json['image'],
        balance = json['balance'];
}
