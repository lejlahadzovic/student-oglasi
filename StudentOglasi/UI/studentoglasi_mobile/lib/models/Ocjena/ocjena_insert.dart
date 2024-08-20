import 'package:json_annotation/json_annotation.dart';

part 'ocjena_insert.g.dart';

@JsonSerializable()
class OcjenaInsert {
  int postId;
  String postType;
  int studentId;
  double ocjena;

  OcjenaInsert(
    this.postId,
    this.postType,
    this.studentId,
    this.ocjena,
  );

  factory OcjenaInsert.fromJson(Map<String, dynamic> json) =>
      _$OcjenaInsertFromJson(json);

  Map<String, dynamic> toJson() => _$OcjenaInsertToJson(this);
}
