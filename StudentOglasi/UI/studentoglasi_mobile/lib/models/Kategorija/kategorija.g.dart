// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kategorija _$KategorijaFromJson(Map<String, dynamic> json) => Kategorija(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$KategorijaToJson(Kategorija instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
