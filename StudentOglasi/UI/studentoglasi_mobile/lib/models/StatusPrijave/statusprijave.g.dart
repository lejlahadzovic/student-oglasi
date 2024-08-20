// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statusprijave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusPrijave _$StatusPrijaveFromJson(Map<String, dynamic> json) =>
    StatusPrijave(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$StatusPrijaveToJson(StatusPrijave instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
