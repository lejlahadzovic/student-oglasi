// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smjestaj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Smjestaj _$SmjestajFromJson(Map<String, dynamic> json) => Smjestaj(
      (json['id'] as num?)?.toInt(),
      json['dodatneUsluge'] as String?,
      json['naziv'] as String?,
      json['adresa'] as String?,
      json['opis'] as String?,
      json['wiFi'] as bool?,
      json['parking'] as bool?,
      json['fitnessCentar'] as bool?,
      json['restoran'] as bool?,
      json['uslugePrijevoza'] as bool?,
      json['grad'] == null
          ? null
          : Grad.fromJson(json['grad'] as Map<String, dynamic>),
      json['tipSmjestaja'] == null
          ? null
          : TipSmjestaja.fromJson(json['tipSmjestaja'] as Map<String, dynamic>),
      (json['smjestajnaJedinicas'] as List<dynamic>?)
          ?.map((e) => SmjestajnaJedinica.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['slike'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['slikes'] as List<dynamic>?)
          ?.map((e) => Slike.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SmjestajToJson(Smjestaj instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'adresa': instance.adresa,
      'dodatneUsluge': instance.dodatneUsluge,
      'opis': instance.opis,
      'wiFi': instance.wiFi,
      'parking': instance.parking,
      'fitnessCentar': instance.fitnessCentar,
      'restoran': instance.restoran,
      'uslugePrijevoza': instance.uslugePrijevoza,
      'grad': instance.grad,
      'tipSmjestaja': instance.tipSmjestaja,
      'smjestajnaJedinicas': instance.smjestajnaJedinicas,
      'slike': instance.slike,
      'slikes': instance.slikes,
    };
