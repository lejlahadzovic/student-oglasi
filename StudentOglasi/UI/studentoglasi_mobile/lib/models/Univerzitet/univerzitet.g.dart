// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'univerzitet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Univerzitet _$UniverzitetFromJson(Map<String, dynamic> json) => Univerzitet(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      (json['fakultetis'] as List<dynamic>?)
          ?.map((e) => Fakultet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UniverzitetToJson(Univerzitet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'fakultetis': instance.fakultetis,
    };
