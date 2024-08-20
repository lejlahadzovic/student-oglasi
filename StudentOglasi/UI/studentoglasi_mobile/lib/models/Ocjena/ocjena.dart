import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';

part 'ocjena.g.dart';

@JsonSerializable()
class Ocjena {
  int postId;
  ItemType postType;
  int studentId;
  double ocjena;

  Ocjena(
    this.postId,
    this.postType,
    this.ocjena,
    this.studentId
  );

  factory Ocjena.fromJson(Map<String, dynamic> json) => _$OcjenaFromJson(json);

  Map<String, dynamic> toJson() => _$OcjenaToJson(this);
}
