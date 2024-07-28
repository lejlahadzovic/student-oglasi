import 'package:json_annotation/json_annotation.dart';

part 'like_count.g.dart';

@JsonSerializable()
class LikeCount {
  int itemId;
  String itemType;
  int count;

  LikeCount(this.itemId, this.itemType, this.count);

  factory LikeCount.fromJson(Map<String, dynamic> json) => _$LikeCountFromJson(json);

  Map<String, dynamic> toJson() => _$LikeCountToJson(this);
}
