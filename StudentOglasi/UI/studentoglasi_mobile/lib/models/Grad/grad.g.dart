// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grad _$GradFromJson(Map<String, dynamic> json) => Grad(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
    );

Map<String, dynamic> _$GradToJson(Grad instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
    };
