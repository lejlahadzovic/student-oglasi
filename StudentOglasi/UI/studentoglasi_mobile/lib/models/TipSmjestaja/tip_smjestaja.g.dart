// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_smjestaja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipSmjestaja _$TipSmjestajaFromJson(Map<String, dynamic> json) => TipSmjestaja(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
    );

Map<String, dynamic> _$TipSmjestajaToJson(TipSmjestaja instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
    };
