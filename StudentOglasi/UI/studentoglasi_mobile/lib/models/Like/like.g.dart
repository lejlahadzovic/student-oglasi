// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like(
      (json['korisnikId'] as num).toInt(),
      (json['itemId'] as num).toInt(),
      $enumDecode(_$ItemTypeEnumMap, json['itemType'],
          unknownValue: ItemType.news),
    );

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'itemId': instance.itemId,
      'itemType': _$ItemTypeEnumMap[instance.itemType]!,
    };

const _$ItemTypeEnumMap = {
  ItemType.news: 'news',
  ItemType.internship: 'internship',
  ItemType.scholarship: 'scholarship',
  ItemType.accommodation: 'accommodation',
  ItemType.accommodationUnit: 'accommodationUnit',
};
