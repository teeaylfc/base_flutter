// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    balance: json['balance'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    cif: json['cif'] as String,
    avatar: json['avatar'] as String,
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'cif': instance.cif,
      'balance': instance.balance,
      'avatar': instance.avatar,
    };
