import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class Pagination {
  final int pageSize;
  final int pageIndex;
  final int totalRecords;
  final int numOfPages;

  Pagination(
      {this.pageSize, this.pageIndex, this.totalRecords, this.numOfPages});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
