// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacije _$RezervacijeFromJson(Map<String, dynamic> json) => Rezervacije(
      (json['studentId'] as num?)?.toInt(),
      (json['smjestajnaJedinicaId'] as num?)?.toInt(),
      json['datumPrijave'] == null
          ? null
          : DateTime.parse(json['datumPrijave'] as String),
      json['datumOdjave'] == null
          ? null
          : DateTime.parse(json['datumOdjave'] as String),
      (json['brojOsoba'] as num?)?.toInt(),
      json['napomena'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      (json['statusId'] as num?)?.toInt(),
      json['smjestajnaJedinica'] == null
          ? null
          : SmjestajnaJedinica.fromJson(
              json['smjestajnaJedinica'] as Map<String, dynamic>),
      json['status'] == null
          ? null
          : StatusPrijave.fromJson(json['status'] as Map<String, dynamic>),
      json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
      json['smjestaj'] == null
          ? null
          : Smjestaj.fromJson(json['smjestaj'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RezervacijeToJson(Rezervacije instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'smjestajnaJedinicaId': instance.smjestajnaJedinicaId,
      'datumPrijave': instance.datumPrijave?.toIso8601String(),
      'datumOdjave': instance.datumOdjave?.toIso8601String(),
      'brojOsoba': instance.brojOsoba,
      'napomena': instance.napomena,
      'cijena': instance.cijena,
      'statusId': instance.statusId,
      'smjestajnaJedinica': instance.smjestajnaJedinica,
      'smjestaj': instance.smjestaj,
      'status': instance.status,
      'student': instance.student,
    };
