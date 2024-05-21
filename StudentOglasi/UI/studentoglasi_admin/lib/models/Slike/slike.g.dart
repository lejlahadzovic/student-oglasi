// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slike _$SlikeFromJson(Map<String, dynamic> json) => Slike(
      json['id'] as int?,
      json['naziv'] as String?,
      json['smjestajId'] as int?,
      json['smjestajnaJedinicaId'] as int?,
    );

Map<String, dynamic> _$SlikeToJson(Slike instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'smjestajId': instance.smjestajId,
      'smjestajnaJedinicaId': instance.smjestajnaJedinicaId,
    };
