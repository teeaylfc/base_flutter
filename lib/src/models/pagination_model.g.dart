// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    pageSize: json['pageSize'] as int,
    pageIndex: json['pageIndex'] as int,
    totalRecords: json['totalRecords'] as int,
    numOfPages: json['numOfPages'] as int,
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'pageIndex': instance.pageIndex,
      'totalRecords': instance.totalRecords,
      'numOfPages': instance.numOfPages,
    };
