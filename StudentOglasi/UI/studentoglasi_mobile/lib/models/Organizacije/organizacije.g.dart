// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organizacije _$OrganizacijeFromJson(Map<String, dynamic> json) => Organizacije(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['telefon'] as String?,
      json['email'] as String?,
      json['adresa'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$OrganizacijeToJson(Organizacije instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'telefon': instance.telefon,
      'email': instance.email,
      'adresa': instance.adresa,
      'link': instance.link,
    };
