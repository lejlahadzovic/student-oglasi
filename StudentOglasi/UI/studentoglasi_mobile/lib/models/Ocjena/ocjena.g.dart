// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjena _$OcjenaFromJson(Map<String, dynamic> json) => Ocjena(
      (json['postId'] as num).toInt(),
      $enumDecode(_$ItemTypeEnumMap, json['postType']),
      (json['ocjena'] as num).toDouble(),
      (json['studentId'] as num).toInt(),
    );

Map<String, dynamic> _$OcjenaToJson(Ocjena instance) => <String, dynamic>{
      'postId': instance.postId,
      'postType': _$ItemTypeEnumMap[instance.postType]!,
      'studentId': instance.studentId,
      'ocjena': instance.ocjena,
    };

const _$ItemTypeEnumMap = {
  ItemType.news: 'news',
  ItemType.internship: 'internship',
  ItemType.scholarship: 'scholarship',
  ItemType.accommodation: 'accommodation',
  ItemType.accommodationUnit: 'accommodationUnit',
};
