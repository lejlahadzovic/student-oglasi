// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjena_average.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcjenaAverage _$OcjenaAverageFromJson(Map<String, dynamic> json) =>
    OcjenaAverage(
      (json['postId'] as num).toInt(),
      (json['averageOcjena'] as num).toDouble(),
    );

Map<String, dynamic> _$OcjenaAverageToJson(OcjenaAverage instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'averageOcjena': instance.averageOcjena,
    };
