import 'package:json_annotation/json_annotation.dart';
part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfile {
  final String name;
  final String phone;
  final String cif;
  final int balance;
  final String avatar;

  UserProfile({this.balance, this.name, this.phone, this.cif, this.avatar});
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  // final String cif;
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
