// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nacin_studiranja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NacinStudiranja _$NacinStudiranjaFromJson(Map<String, dynamic> json) =>
    NacinStudiranja(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$NacinStudiranjaToJson(NacinStudiranja instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
