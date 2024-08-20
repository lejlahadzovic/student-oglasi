// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prijave_stipendija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrijaveStipendija _$PrijaveStipendijaFromJson(Map<String, dynamic> json) =>
    PrijaveStipendija(
      (json['studentId'] as num?)?.toInt(),
      (json['stipendijaId'] as num?)?.toInt(),
      json['dokumentacija'] as String?,
      json['cv'] as String?,
      (json['prosjekOcjena'] as num?)?.toDouble(),
      json['status'] == null
          ? null
          : StatusPrijave.fromJson(json['status'] as Map<String, dynamic>),
      json['stipendija'] == null
          ? null
          : Stipendije.fromJson(json['stipendija'] as Map<String, dynamic>),
      json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrijaveStipendijaToJson(PrijaveStipendija instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'stipendijaId': instance.stipendijaId,
      'dokumentacija': instance.dokumentacija,
      'cv': instance.cv,
      'prosjekOcjena': instance.prosjekOcjena,
      'status': instance.status,
      'stipendija': instance.stipendija,
      'student': instance.student,
    };
