// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oglas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Oglas _$OglasFromJson(Map<String, dynamic> json) => Oglas(
      (json['id'] as num?)?.toInt(),
      json['naslov'] as String?,
      DateTime.parse(json['rokPrijave'] as String),
      json['opis'] as String?,
      json['vrijemeObjave'] == null
          ? null
          : DateTime.parse(json['vrijemeObjave'] as String),
      json['slika'] as String?,
    );

Map<String, dynamic> _$OglasToJson(Oglas instance) => <String, dynamic>{
      'id': instance.id,
      'naslov': instance.naslov,
      'rokPrijave': instance.rokPrijave.toIso8601String(),
      'opis': instance.opis,
      'vrijemeObjave': instance.vrijemeObjave?.toIso8601String(),
      'slika': instance.slika,
    };
