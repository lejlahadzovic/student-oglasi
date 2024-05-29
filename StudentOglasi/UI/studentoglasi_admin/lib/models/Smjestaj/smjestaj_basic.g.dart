// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smjestaj_basic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmjestajBasic _$SmjestajBasicFromJson(Map<String, dynamic> json) =>
    SmjestajBasic(
      json['id'] as int?,
      json['naziv'] as String?,
      json['adresa'] as String?,
      json['opis'] as String?,
      json['grad'] as String?,
      json['tipSmjestaja'] as String?,
    );

Map<String, dynamic> _$SmjestajBasicToJson(SmjestajBasic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'adresa': instance.adresa,
      'opis': instance.opis,
      'grad': instance.grad,
      'tipSmjestaja': instance.tipSmjestaja,
    };
