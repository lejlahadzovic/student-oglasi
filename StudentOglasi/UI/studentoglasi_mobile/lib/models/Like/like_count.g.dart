// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeCount _$LikeCountFromJson(Map<String, dynamic> json) => LikeCount(
      (json['itemId'] as num).toInt(),
      json['itemType'] as String,
      (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$LikeCountToJson(LikeCount instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'itemType': instance.itemType,
      'count': instance.count,
    };
