// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Komentar _$KomentarFromJson(Map<String, dynamic> json) => Komentar(
      (json['id'] as num).toInt(),
      (json['postId'] as num).toInt(),
      $enumDecode(_$ItemTypeEnumMap, json['postType']),
      (json['parentKomentarId'] as num?)?.toInt(),
      json['vrijemeObjave'] == null
          ? null
          : DateTime.parse(json['vrijemeObjave'] as String),
      json['text'] as String,
      json['ime'] as String,
      json['prezime'] as String,
      odgovori: (json['odgovori'] as List<dynamic>?)
              ?.map((e) => Komentar.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$KomentarToJson(Komentar instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'postType': _$ItemTypeEnumMap[instance.postType]!,
      'parentKomentarId': instance.parentKomentarId,
      'vrijemeObjave': instance.vrijemeObjave?.toIso8601String(),
      'text': instance.text,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'odgovori': instance.odgovori,
    };

const _$ItemTypeEnumMap = {
  ItemType.news: 'news',
  ItemType.internship: 'internship',
  ItemType.scholarship: 'scholarship',
  ItemType.accommodation: 'accommodation',
  ItemType.accommodationUnit: 'accommodationUnit',
};
