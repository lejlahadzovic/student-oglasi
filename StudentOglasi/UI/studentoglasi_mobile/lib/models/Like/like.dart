import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';

part 'like.g.dart';

@JsonSerializable()
class Like {
   int korisnikId;
   int itemId;
   @JsonKey(unknownEnumValue: ItemType.news)
   ItemType itemType;

  Like(this.korisnikId, this.itemId, this.itemType);

  factory Like.fromJson(Map<String, dynamic> json) =>
      _$LikeFromJson(json);

  Map<String, dynamic> toJson() => _$LikeToJson(this);
}
