// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statusoglasi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusOglasi _$StatusOglasiFromJson(Map<String, dynamic> json) => StatusOglasi(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$StatusOglasiToJson(StatusOglasi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
