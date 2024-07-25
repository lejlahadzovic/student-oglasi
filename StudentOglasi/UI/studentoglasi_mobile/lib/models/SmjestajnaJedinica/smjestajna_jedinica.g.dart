// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smjestajna_jedinica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmjestajnaJedinica _$SmjestajnaJedinicaFromJson(Map<String, dynamic> json) =>
    SmjestajnaJedinica(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      (json['kapacitet'] as num?)?.toInt(),
      json['opis'] as String?,
      json['kuhinja'] as bool?,
      json['tv'] as bool?,
      json['klimaUredjaj'] as bool?,
      json['terasa'] as bool?,
      json['dodatneUsluge'] as String?,
      (json['smjestajId'] as num?)?.toInt(),
      (json['slike'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['slikes'] as List<dynamic>?)
          ?.map((e) => Slike.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SmjestajnaJedinicaToJson(SmjestajnaJedinica instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'cijena': instance.cijena,
      'kapacitet': instance.kapacitet,
      'opis': instance.opis,
      'kuhinja': instance.kuhinja,
      'tv': instance.tv,
      'klimaUredjaj': instance.klimaUredjaj,
      'terasa': instance.terasa,
      'dodatneUsluge': instance.dodatneUsluge,
      'smjestajId': instance.smjestajId,
      'slike': instance.slike,
      'slikes': instance.slikes,
    };
