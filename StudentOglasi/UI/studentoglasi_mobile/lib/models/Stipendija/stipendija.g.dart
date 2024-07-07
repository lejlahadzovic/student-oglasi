// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stipendija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stipendije _$StipendijeFromJson(Map<String, dynamic> json) => Stipendije(
      (json['id'] as num?)?.toInt(),
      json['uslovi'] as String?,
      (json['iznos'] as num?)?.toDouble(),
      json['kriterij'] as String?,
      json['potrebnaDokumentacija'] as String?,
      json['izvor'] as String?,
      json['nivoObrazovanja'] as String?,
      (json['brojStipendisata'] as num?)?.toInt(),
      json['idNavigation'] == null
          ? null
          : Oglas.fromJson(json['idNavigation'] as Map<String, dynamic>),
      json['status'] == null
          ? null
          : StatusOglasi.fromJson(json['status'] as Map<String, dynamic>),
      json['stipenditor'] == null
          ? null
          : Stipenditor.fromJson(json['stipenditor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StipendijeToJson(Stipendije instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uslovi': instance.uslovi,
      'iznos': instance.iznos,
      'kriterij': instance.kriterij,
      'potrebnaDokumentacija': instance.potrebnaDokumentacija,
      'izvor': instance.izvor,
      'nivoObrazovanja': instance.nivoObrazovanja,
      'brojStipendisata': instance.brojStipendisata,
      'idNavigation': instance.idNavigation,
      'status': instance.status,
      'stipenditor': instance.stipenditor,
    };
