// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['id'] as int?,
      json['brojIndeksa'] as String?,
      json['godinaStudija'] as int?,
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
      json['status'] as bool?,
      Fakultet.fromJson(json['fakultet'] as Map<String, dynamic>),
      Korisnik.fromJson(json['idNavigation'] as Map<String, dynamic>),
      NacinStudiranja.fromJson(json['nacinStudiranja'] as Map<String, dynamic>),
      Smjer.fromJson(json['smjer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'brojIndeksa': instance.brojIndeksa,
      'godinaStudija': instance.godinaStudija,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
      'status': instance.status,
      'fakultet': instance.fakultet,
      'idNavigation': instance.idNavigation,
      'nacinStudiranja': instance.nacinStudiranja,
      'smjer': instance.smjer,
    };
