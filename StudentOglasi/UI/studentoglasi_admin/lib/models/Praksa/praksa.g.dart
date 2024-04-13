// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'praksa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Praksa _$PraksaFromJson(Map<String, dynamic> json) => Praksa(
      json['id'] as int?,
      json['pocetakPrakse'] == null
          ? null
          : DateTime.parse(json['pocetakPrakse'] as String),
      json['krajPrakse'] == null
          ? null
          : DateTime.parse(json['krajPrakse'] as String),
      json['kvalifikacije'] as String?,
      json['benefiti'] as String?,
      json['idNavigation'] == null
          ? null
          : Oglas.fromJson(json['idNavigation'] as Map<String, dynamic>),
    )
      ..placena = json['placena'] as bool?
      ..status = json['status'] == null
          ? null
          : StatusOglasi.fromJson(json['status'] as Map<String, dynamic>)
      ..organizacija = json['organizacija'] == null
          ? null
          : Organizacije.fromJson(json['organizacija'] as Map<String, dynamic>);

Map<String, dynamic> _$PraksaToJson(Praksa instance) => <String, dynamic>{
      'id': instance.id,
      'pocetakPrakse': instance.pocetakPrakse?.toIso8601String(),
      'krajPrakse': instance.krajPrakse?.toIso8601String(),
      'kvalifikacije': instance.kvalifikacije,
      'benefiti': instance.benefiti,
      'placena': instance.placena,
      'idNavigation': instance.idNavigation,
      'status': instance.status,
      'organizacija': instance.organizacija,
    };
