// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijesti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavijesti _$ObavijestiFromJson(Map<String, dynamic> json) => Obavijesti(
      (json['id'] as num?)?.toInt(),
      (json['oglasId'] as num?)?.toInt(),
      (json['smjestajId'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
      json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
    );

Map<String, dynamic> _$ObavijestiToJson(Obavijesti instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oglasId': instance.oglasId,
      'smjestajId': instance.smjestajId,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
    };
