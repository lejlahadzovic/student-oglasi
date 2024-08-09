// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjena_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcjenaInsert _$OcjenaInsertFromJson(Map<String, dynamic> json) => OcjenaInsert(
      (json['postId'] as num).toInt(),
      json['postType'] as String,
      (json['studentId'] as num).toInt(),
      (json['ocjena'] as num).toDouble(),
    );

Map<String, dynamic> _$OcjenaInsertToJson(OcjenaInsert instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'postType': instance.postType,
      'studentId': instance.studentId,
      'ocjena': instance.ocjena,
    };
