// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stipenditor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stipenditor _$StipenditorFromJson(Map<String, dynamic> json) => Stipenditor(
      json['id'] as int?,
      json['naziv'] as String?,
      json['telefon'] as String?,
      json['email'] as String?,
      json['adresa'] as String?,
      json['link'] as String?,
      json['gradId'] as int?,
    );

Map<String, dynamic> _$StipenditorToJson(Stipenditor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'telefon': instance.telefon,
      'email': instance.email,
      'adresa': instance.adresa,
      'link': instance.link,
      'gradId': instance.gradId,
    };
