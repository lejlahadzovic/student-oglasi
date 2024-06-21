// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smjer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Smjer _$SmjerFromJson(Map<String, dynamic> json) => Smjer(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$SmjerToJson(Smjer instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
