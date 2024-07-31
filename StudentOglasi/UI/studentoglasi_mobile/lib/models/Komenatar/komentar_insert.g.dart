// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentar_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomentarInsert _$KomentarInsertFromJson(Map<String, dynamic> json) =>
    KomentarInsert(
      (json['postId'] as num).toInt(),
      json['postType'] as String,
      (json['parentKomentarId'] as num?)?.toInt(),
      (json['korisnikId'] as num).toInt(),
      json['text'] as String,
    );

Map<String, dynamic> _$KomentarInsertToJson(KomentarInsert instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'postType': instance.postType,
      'parentKomentarId': instance.parentKomentarId,
      'korisnikId': instance.korisnikId,
      'text': instance.text,
    };
