// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prijave_praksa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrijavePraksa _$PrijavePraksaFromJson(Map<String, dynamic> json) =>
    PrijavePraksa(
      (json['studentId'] as num?)?.toInt(),
      (json['praksaId'] as num?)?.toInt(),
      json['propratnoPismo'] as String?,
      json['cv'] as String?,
      json['certifikati'] as String?,
      (json['statusId'] as num?)?.toInt(),
      json['praksa'] == null
          ? null
          : Praksa.fromJson(json['praksa'] as Map<String, dynamic>),
      json['status'] == null
          ? null
          : StatusPrijave.fromJson(json['status'] as Map<String, dynamic>),
      json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrijavePraksaToJson(PrijavePraksa instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'praksaId': instance.praksaId,
      'propratnoPismo': instance.propratnoPismo,
      'cv': instance.cv,
      'certifikati': instance.certifikati,
      'statusId': instance.statusId,
      'praksa': instance.praksa,
      'status': instance.status,
      'student': instance.student,
    };
