// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fakultet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fakultet _$FakultetFromJson(Map<String, dynamic> json) => Fakultet(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      (json['smjerovi'] as List<dynamic>?)
          ?.map((e) => Smjer.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..univerzitetId = (json['univerzitetId'] as num?)?.toInt();

Map<String, dynamic> _$FakultetToJson(Fakultet instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'smjerovi': instance.smjerovi,
      'univerzitetId': instance.univerzitetId,
    };
