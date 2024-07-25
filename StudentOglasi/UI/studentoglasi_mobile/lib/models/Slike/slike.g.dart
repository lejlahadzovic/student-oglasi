// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slike _$SlikeFromJson(Map<String, dynamic> json) => Slike(
      (json['slikaId'] as num?)?.toInt(),
      json['naziv'] as String?,
      (json['smjestajId'] as num?)?.toInt(),
      (json['smjestajnaJedinicaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SlikeToJson(Slike instance) => <String, dynamic>{
      'slikaId': instance.slikaId,
      'naziv': instance.naziv,
      'smjestajId': instance.smjestajId,
      'smjestajnaJedinicaId': instance.smjestajnaJedinicaId,
    };
